import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;
  Set<Marker> _markers = {};
  LatLng? selectedLocation;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onTap(LatLng location) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Qué quieres hacer?'),
          actions: <Widget>[
            TextButton(
              child: Text('Ver'),
              onPressed: () {
                setState(() {
                  selectedLocation = location;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () async {
                await FirebaseFirestore.instance.collection('maps_user').add({
                  'a_latitud': location.latitude,
                  'b_longitud': location.longitude,
                });
                setState(() {
                  _markers.add(Marker(
                    markerId: MarkerId(location.toString()),
                    position: location,
                    draggable: true,
                    onTap: () {
                      _onTap(location);
                    },
                    onDragEnd: (newPosition) {
                      _markers.removeWhere(
                          (m) => m.markerId.value == location.toString());
                    },
                  ));

                  selectedLocation = location;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Quitar'),
              onPressed: () {
                setState(() {
                  _markers.removeWhere(
                      (m) => m.markerId.value == location.toString());
                  selectedLocation = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _searchAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      _controller.moveCamera(CameraUpdate.newLatLng(
          LatLng(locations[0].latitude, locations[0].longitude)));
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Parqueos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: _searchAddress,
              decoration: InputDecoration(
                hintText: 'Ingresa una dirección',
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: () => _searchAddress,
                  icon: Icon(Icons.search, color: Colors.white),
                ),
                fillColor: Colors.white24,
                filled: true,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text('Parqueos',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text('Navega por el mapa y elige algun parqueo disponible',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  onTap: _onTap,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-34.6037, -58.3816),
                    zoom: 7,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.white,
            child: selectedLocation != null
                ? Text(
                    'Latitud: ${selectedLocation!.latitude}, Longitud: ${selectedLocation!.longitude}',
                    style: TextStyle(color: Colors.black),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
