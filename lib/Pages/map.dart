import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickparking_flutter/Widget/BottomSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickparking_flutter/Widget/marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class MapView extends StatefulWidget {
  final String searchQuery;
  final LatLng? newMarkerCoords;
  final String? newMarkerId;

  MapView(
      {Key? key, this.searchQuery = '', this.newMarkerCoords, this.newMarkerId})
      : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Map<String, dynamic>? selectedParqueoData;

  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  bool isMapControllerInitialized = false;

  final LatLng _initialCenter = LatLng(-15.7942, -47.8822);
  final double _initialZoom = 3.5;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _retrieveMarkers();
    _loadMarkers();
    print("Nuevas coordenadas del marcador: ${widget.newMarkerCoords}");
    print("ID del nuevo marcador: ${widget.newMarkerId}");
    if (widget.searchQuery.isNotEmpty) {
      _searchAddress(widget.searchQuery);
    }
    if (widget.newMarkerCoords != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mapController != null) {
          mapController.animateCamera(
            CameraUpdate.newLatLng(widget.newMarkerCoords!),
          );
        }
      });
    }
  }

  void _loadMarkers() async {
    var collection = FirebaseFirestore.instance.collection('parqueosgp');
    var querySnapshot = await collection.get();
    Set<Marker> newMarkers = {};

    for (var doc in querySnapshot.docs) {
      var parqueoData = doc.data() as Map<String, dynamic>;
      var geoPoint = parqueoData['coords'];
      if (geoPoint is GeoPoint) {
        LatLng position = LatLng(geoPoint.latitude, geoPoint.longitude);
        String parqueoId = doc.id;

        newMarkers.add(
          Marker(
            markerId: MarkerId(parqueoId),
            position: position,
            onTap: () => _onMarkerTapped(parqueoId),
          ),
        );
      }
    }

    setState(() {
      _markers = newMarkers;
    });
  }

  void _retrieveMarkers() async {
    var collection = FirebaseFirestore.instance.collection('parqueosgp');
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      var geoPoint = data['coords'];

      if (geoPoint is GeoPoint) {
        LatLng markerPosition = LatLng(geoPoint.latitude, geoPoint.longitude);
        String markerId = doc.id;

        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId(markerId),
              position: markerPosition,
            ),
          );
        });
      } else {
        print("El tipo de datos para las coordenadas no es un GeoPoint.");
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    if (widget.newMarkerCoords != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: widget.newMarkerCoords!,
            zoom: 17.0,
          ),
        ),
      );
    }

    if (widget.newMarkerCoords != null && widget.newMarkerId != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _addMarker(widget.newMarkerCoords!, widget.newMarkerId!);
      });
    }
  }

  void _addMarker(LatLng position, String markerId) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          onTap: () => _onMarkerTapped(markerId),
        ),
      );
    });

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 14.0,
        ),
      ),
    );
  }

  void _onMarkerTapped(String parqueoId) async {
    print("Marker tapped: $parqueoId");
    var docSnapshot = await FirebaseFirestore.instance
        .collection('parqueosgp')
        .doc(parqueoId)
        .get();
    var parqueoData = docSnapshot.data();

    if (parqueoData != null) {
      setState(() {
        selectedParqueoData = parqueoData;
        _visibility = true;
      });
    }
  }

  void _searchAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locations[0].latitude, locations[0].longitude),
        ),
      );
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: Icon(Icons.arrow_back_ios,
                color: Colors.black.withOpacity(0.6), size: 20),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _initialCenter, zoom: _initialZoom),
              markers: _markers), //revisar
          Padding(
            padding: const EdgeInsets.only(
                left: 28, top: 100, right: 28, bottom: 10),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide.none,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  title: TextField(
                    controller: searchController,
                    decoration: InputDecoration.collapsed(
                      hintText: '¿A dónde vas?',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        letterSpacing: 0.2,
                      ),
                    ),
                    onSubmitted: (_) => _searchAddress(searchController.text),
                  ),
                  trailing: GestureDetector(
                    onTap: () => _searchAddress(searchController.text),
                    child:
                        Icon(Icons.search, size: 27, color: Colors.orange[400]),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visibility && selectedParqueoData != null,
            child: selectedParqueoData != null
                ? DraggableSheet(parqueoData: selectedParqueoData!)
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  bool _visibility = false;
  void _showBottomSheet() {
    setState(() {
      _visibility = !_visibility;
    });
  }
}

//