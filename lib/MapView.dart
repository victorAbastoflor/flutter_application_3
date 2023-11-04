import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onTap(LatLng location) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: const InfoWindow(
            title: 'Parqueo', snippet: 'Información del parqueo'),
      ));
    });

    // Agregar la ubicación a Firestore

    FirebaseFirestore.instance.collection('maps_users').add({
      'a_latitud': location.latitude,
      'b_longitud': location.longitude,
    });
  }

  void _searchAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      _controller.moveCamera(CameraUpdate.newLatLng(
          LatLng(locations[0].latitude, locations[0].longitude)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          onTap: _onTap,
          markers: _markers,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 10,
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          right: 10,
          child: TextField(
            onSubmitted: _searchAddress,
            decoration: const InputDecoration(
              hintText: 'Ingresa una dirección',
            ),
          ),
        ),
      ],
    );
  }
}
