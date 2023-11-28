import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Pages/home.dart';
import 'package:quickparking_flutter/Pages/payment.dart';
import 'package:quickparking_flutter/owner/owner_home.dart';
import 'package:quickparking_flutter/Pages/reserva_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReciboScreen extends StatefulWidget {
  final Reserva reserva;

  ReciboScreen({required this.reserva});

  @override
  _ReciboScreenState createState() => _ReciboScreenState();
}

class _ReciboScreenState extends State<ReciboScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nombreCompleto = widget.reserva.nombreCompleto ?? 'No especificado';
    String numeroCelular = widget.reserva.numTel ?? 'No especificado';
    String nit = widget.reserva.nit ?? 'No especificado';
    String placaVehiculo = widget.reserva.placaVehiculo ?? 'No especificado';
    String horas = widget.reserva.horas?.toString() ?? 'No especificado';
    String totalPagar = widget.reserva.total?.toString() ?? 'No especificado';

    String parqueoId = widget.reserva.parqueoId ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Recibo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 32),
                Center(
                  child: Image.asset(
                    'image/qr_code.jpg',
                    width: 220,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                // Tus otros widgets aquí...
                _buildInfoRow('Nombre',
                    widget.reserva.nombreCompleto ?? 'No especificado'),
                _buildInfoRow(
                    'Teléfono', widget.reserva.numTel ?? 'No especificado'),
                _buildInfoRow('NIT', widget.reserva.nit ?? 'No especificado'),
                _buildInfoRow('Placa Vehículo',
                    widget.reserva.placaVehiculo ?? 'No especificado'),
                _buildInfoRow('Horas',
                    widget.reserva.horas?.toString() ?? 'No especificado'),
                _buildInfoRow('Total a Pagar',
                    '\$${widget.reserva.total?.toString() ?? 'No especificado'}'),
                SizedBox(height: 20),

                Text(
                  'Dirección del Parqueo',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                      fontSize: 13,
                      letterSpacing: 0.2),
                ),
                SizedBox(height: 8),
                FutureBuilder<String>(
                  future: _cargarUbicacionParqueo(parqueoId),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error al cargar la ubicación'));
                    } else {
                      return Text(
                        snapshot.data ?? 'Dirección no disponible',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            fontSize: 16.4,
                            letterSpacing: 0.2),
                      );
                    }
                  },
                ),
                SizedBox(height: 144),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 6,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      child: Text(
                        'INICIO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          wordSpacing: 2,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _cargarUbicacionParqueo(String parqueoId) async {
    DocumentSnapshot parqueoDoc = await FirebaseFirestore.instance
        .collection('parqueosgp')
        .doc(parqueoId)
        .get();

    if (parqueoDoc.exists && parqueoDoc.data() is Map<String, dynamic>) {
      Map<String, dynamic> data = parqueoDoc.data() as Map<String, dynamic>;
      return data['ubicacion'] ?? 'Ubicación no disponible';
    } else {
      return 'Ubicación no disponible';
    }
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
                fontSize: 13)),
        Text(value,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
      ],
    );
  }
}
