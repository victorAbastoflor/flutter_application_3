import 'package:flutter/material.dart';
import 'package:flutter_application_3/Compo_model.dart';
import 'package:flutter_application_3/DBparkeosRecord.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapViewLoad extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapViewLoad> {
  late GoogleMapController _controller;
  DBparkeosRecord? parkeoRecord;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  void initState() {
    super.initState();
    _loadMarkersFromFirestore();
  }

  void _loadMarkersFromFirestore() {
    FirebaseFirestore.instance
        .collection('DBparkeos')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final latitudlongitud = data['latitudlongitud'] as GeoPoint;
        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(doc.id),
            position:
                LatLng(latitudlongitud.latitude, latitudlongitud.longitude),
            draggable: true,
            onTap: () {
              /*setState(() {
                parkeoRecord = record; // Asigna el registro a parkeoRecord
              });*/
              _showCustomWidget(doc); // Mostrar widget personalizado
            },
            onDragEnd: (newPosition) {
              // Puedes manejar el evento de arrastre aquí si es necesario.
            },
          ));
        });
      });
    });
  }

/*
  void _showCustomWidget(DBparkeosRecord record) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CompoWidget(ubicacionref: record);
      },
    );
  }*/
  void _showCustomWidget(DocumentSnapshot doc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: 350,
          height: 220,
          decoration: BoxDecoration(
            color: Color(0x66000000),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        doc['image'],
                        width: MediaQuery.of(context).size.width * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['nombre'],
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            doc['direccion'],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFC3C3C3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precio',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFC3C3C3),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                doc['precio'].toString(),
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(
                                  'bs/HR',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Espacios disponibles',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFC3C3C3),
                            ),
                          ),
                          Text(
                            doc['numplazas'].toString(),
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Distancia/KM',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFC3C3C3),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '02',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(
                                  'KM',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          print('Reservar ahora button pressed ...');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                          primary: Colors.white,
                          backgroundColor: Color(0xFF651A1A),
                          textStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 14,
                          ),
                        ),
                        child: Text('Reservar ahora'),
                      ),
                      TextButton(
                        onPressed: () {
                          print('Entrar button pressed ...');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                          primary: Colors.white,
                          backgroundColor: Color(0xFFEF6939),
                          textStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 14,
                          ),
                        ),
                        child: Text('Entrar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  /*
  void _showCustomWidget(DocumentSnapshot doc) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              Text(
                  doc['nombre']), // Personaliza el contenido según tu necesidad
              // Agrega más widgets aquí según tus necesidades
            ],
          ),
        );
      },
    );
  }*/

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
          Text('Parqueos',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text('Navega por el mapa y elige algún parqueo disponible',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-17.0568696, -64.9912286),
                    zoom: 7,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
