import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quickparking_flutter/Paint/CustomPaintHome.dart';

class ParkingDetailsPage extends StatefulWidget {
  final String parqueoId;

  ParkingDetailsPage({required this.parqueoId});

  @override
  _ParkingDetailsPageState createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  void _reloadData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Color miColor = Color(0xFFB71C1C);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Parqueo'),
        backgroundColor: miColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('parqueosgp')
            .doc(widget.parqueoId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('Parqueo no encontrado'));
          }

          var parqueoData = snapshot.data!.data() as Map<String, dynamic>;
          List<dynamic> images = parqueoData['imagenes'] as List<dynamic> ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildDetailRow('Nombre', parqueoData['nombre']),
                      _buildDetailRow('Ubicación', parqueoData['ubicacion']),
                      _buildDetailRow(
                          'Latitud', parqueoData['coords'].latitude.toString()),
                      _buildDetailRow('Longitud',
                          parqueoData['coords'].longitude.toString()),
                      _buildDetailRow(
                          'Espacios', parqueoData['espacios'].toString()),
                      _buildDetailRow('Horario', parqueoData['horario']),
                      _buildDetailRow('Espacios Disponibles',
                          parqueoData['espaciosDisponibles'].toString()),
                      _buildDetailRow('Costo por Hora',
                          '\$${parqueoData['horaCosto'].toStringAsFixed(2)}'),
                      _buildVehiclesAllowed(parqueoData['vehiculos']),
                      _buildImages(images),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          Text('$title: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildVehiclesAllowed(Map<String, dynamic> vehicles) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          Text('Vehículos Permitidos: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(vehicles['autos'] ? 'Autos ' : ''),
          Text(vehicles['motos'] ? 'Motos ' : ''),
          Text(vehicles['camiones'] ? 'Camiones ' : ''),
        ],
      ),
    );
  }

  Widget _buildImages(List<dynamic> images) {
    return Column(
      children: images.map((imageUrl) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      }).toList(),
    );
  }
}
