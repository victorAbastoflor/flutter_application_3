import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:quickparking_flutter/owner/cronometer.dart';
import 'package:provider/provider.dart';
import 'package:quickparking_flutter/Pages/reserva_model.dart';
import 'package:quickparking_flutter/Pages/recipt_client.dart';

class DetalleReservaClienteScreen extends StatefulWidget {
  final Reserva reserva;

  DetalleReservaClienteScreen({required this.reserva});

  @override
  _DetalleReservaClienteScreenState createState() =>
      _DetalleReservaClienteScreenState();
}

class _DetalleReservaClienteScreenState
    extends State<DetalleReservaClienteScreen> {
  String nombreParqueo = '';
  late String tiempoTranscurrido;
  late Duration _elapsedTime;

  @override
  void initState() {
    super.initState();
    _obtenerNombreParqueo(widget.reserva.parqueoId);
    _elapsedTime = Duration.zero;
    _loadElapsedTimeFromFirestore();
    tiempoTranscurrido = _formattedElapsedTime(_elapsedTime);
  }

  void _obtenerNombreParqueo(String parqueoId) async {
    var documento = await FirebaseFirestore.instance
        .collection('parqueosgp')
        .doc(parqueoId)
        .get();
    if (documento.exists) {
      setState(() {
        nombreParqueo = documento.data()!['nombre'] ?? 'Nombre no disponible';
      });
    }
  }

  Future<void> _loadElapsedTimeFromFirestore() async {
    var reservaDoc = await FirebaseFirestore.instance
        .collection('reservasgp')
        .doc(widget.reserva.id)
        .get();

    if (reservaDoc.exists) {
      int tiempoGuardado = reservaDoc['tiempoTranscurrido'] ?? 0;
      _elapsedTime = Duration(milliseconds: tiempoGuardado);
      tiempoTranscurrido = _formattedElapsedTime(_elapsedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cronometro = Provider.of<CronometroModel>(context);
    String tiempoTranscurrido = _formattedElapsedTime(cronometro.elapsedTime);

    String formattedDate = DateFormat('dd/MM/yyyy HH:mm')
        .format(widget.reserva.horaInicio.toDate());

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Reserva'),
        backgroundColor: Colors.red[900],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nombre del Parqueo: $nombreParqueo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Nombre: ${widget.reserva.nombreCompleto}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Placa del Vehículo: ${widget.reserva.placaVehiculo}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Hora de Inicio: $formattedDate',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Duración: ${widget.reserva.horas} horas',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Total: \$${widget.reserva.total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Estado: ${widget.reserva.estado}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Tiempo Transcurrido: $tiempoTranscurrido'),
            SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      print(
                          'Pasando reserva a ReciboScreen: ${widget.reserva}');
                      return ReciboScreen(reserva: widget.reserva);
                    },
                  ),
                );
              },
              child: Text('Ver Recibo', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  String _formattedElapsedTime(Duration elapsed) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(elapsed.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(elapsed.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

// class Reserva {
//   String id;
//   String nombreCompleto;
//   String placaVehiculo;
//   int horas;
//   double total;
//   String numTel;
//   String nit;
//   String parqueoId;
//   String estado; // 'pendiente', 'en curso', 'finalizada'
//   Timestamp horaInicio;

//   Reserva({
//     required this.id,
//     required this.nombreCompleto,
//     required this.placaVehiculo,
//     required this.horas,
//     required this.total,
//     required this.numTel,
//     required this.nit,
//     required this.parqueoId,
//     required this.estado,
//     required this.horaInicio,
//   });
// }
