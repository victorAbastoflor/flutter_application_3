import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickparking_flutter/Widget/recents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:quickparking_flutter/main.dart';
import 'package:quickparking_flutter/owner/cronometer.dart';
import 'package:provider/provider.dart';

class DetalleReservaScreen extends StatefulWidget {
  final Reserva reserva;

  DetalleReservaScreen({required this.reserva});

  @override
  _DetalleReservaScreenState createState() => _DetalleReservaScreenState();
}

class _DetalleReservaScreenState extends State<DetalleReservaScreen> {
  String nombreParqueo = '';
  late Stopwatch _stopwatch;
  late String tiempoTranscurrido;
  late Timer _timer;
  late Duration _elapsedTime;

  @override
  void initState() {
    super.initState();
    _obtenerNombreParqueo(widget.reserva.parqueoId);
    _stopwatch = Stopwatch();
    _elapsedTime = Duration.zero;
    _loadElapsedTimeFromFirestore();
    tiempoTranscurrido = _formattedElapsedTime(_elapsedTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    _saveElapsedTimeToFirestore(_elapsedTime);
    super.dispose();
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

  void _toggleTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime = _stopwatch.elapsed;
          tiempoTranscurrido = _formattedElapsedTime(_elapsedTime);
        });
      });
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    _elapsedTime = Duration.zero;
    tiempoTranscurrido = _formattedElapsedTime(_elapsedTime);
    _saveElapsedTimeToFirestore(_elapsedTime);
    if (_stopwatch.isRunning) {
      _timer.cancel();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime = _stopwatch.elapsed;
          tiempoTranscurrido = _formattedElapsedTime(_elapsedTime);
        });
      });
    }
  }

  Future<void> _saveElapsedTimeToFirestore(Duration elapsed) async {
    await FirebaseFirestore.instance
        .collection('reservasgp')
        .doc(widget.reserva.id)
        .update({'tiempoTranscurrido': elapsed.inMilliseconds});
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
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm')
        .format(widget.reserva.horaInicio.toDate());
    final cronometro = Provider.of<CronometroModel>(context);
    String tiempoTranscurrido = _formattedElapsedTime(cronometro.elapsedTime);

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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => cronometro.startTimer(),
                  child: Text('Iniciar'),
                ),
                ElevatedButton(
                  onPressed: () => cronometro.stopTimer(),
                  child: Text('Parar'),
                ),
                ElevatedButton(
                  onPressed: () => cronometro.resetTimer(),
                  child: Text('Reiniciar'),
                ),
              ],
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
