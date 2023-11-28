import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Paint/CustomPaintHome.dart';
import 'package:quickparking_flutter/Transitions/FadeTransition.dart';
import 'package:quickparking_flutter/Pages/map.dart';
import 'package:quickparking_flutter/Widget/recents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickparking_flutter/owner/parking_details.dart';
import 'package:quickparking_flutter/Pages/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickparking_flutter/Pages/list_reservas.dart';
import 'package:quickparking_flutter/owner/profile_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TopBar_home(),
          Column(
            children: <Widget>[
              _buildAppBar(context),
              _buildSearchBar(context),
              Expanded(child: _buildParkingList(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: Icon(Icons.airport_shuttle_outlined,
                color: Colors.white.withOpacity(0.9), size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaReservasCliente()),
              );
            },
          ),
        ),
        title: Center(
          child: Text(
            'PARQUEOS',
            style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quickstand'),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.assignment_ind_outlined,
                color: Colors.white.withOpacity(0.9),
                size: 24,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    void _searchAndNavigate() {
      String searchQuery = searchController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapView(searchQuery: searchQuery),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: ListTile(
          title: TextField(
            controller: searchController,
            enabled: true,
            decoration: InputDecoration.collapsed(
              hintText: '¿A dónde vas?',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                letterSpacing: 0.2,
              ),
            ),
            onSubmitted: (_) => _searchAndNavigate(),
          ),
          trailing: GestureDetector(
            onTap: _searchAndNavigate,
            child: Icon(Icons.search, size: 27, color: Colors.orange[400]),
          ),
        ),
      ),
    );
  }

  Widget _buildParkingList(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('parqueosgp').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error al cargar parqueos');
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var documentSnapshot = snapshot.data!.docs[index];
            var parqueo = documentSnapshot.data() as Map<String, dynamic>;
            String nombre = parqueo.containsKey('nombre')
                ? parqueo['nombre']
                : 'Nombre no disponible';
            String ubicacion = parqueo.containsKey('ubicacion')
                ? parqueo['ubicacion']
                : 'Ubicación no disponible';
            GeoPoint? geoPoint = parqueo['coords'] as GeoPoint?;
            LatLng? latLng = geoPoint != null
                ? LatLng(geoPoint.latitude, geoPoint.longitude)
                : null;
            return Card(
              color: Colors.black,
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: ListTile(
                title: Text(nombre, style: TextStyle(color: Colors.white)),
                subtitle:
                    Text(ubicacion, style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ParkingDetailsPage(parqueoId: documentSnapshot.id),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.location_on, color: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapView(newMarkerCoords: latLng),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
