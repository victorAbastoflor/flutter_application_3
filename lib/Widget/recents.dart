import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:quickparking_flutter/owner/booking_screen.dart';

class Recents extends StatefulWidget {
  @override
  State createState() => _RecentState();
}

class Reserva {
  String id;
  String nombreCompleto;
  String placaVehiculo;
  int horas;
  double total;
  String numTel;
  String nit;
  String parqueoId;
  String estado;
  Timestamp horaInicio;

  Reserva({
    required this.id,
    required this.nombreCompleto,
    required this.placaVehiculo,
    required this.horas,
    required this.total,
    required this.numTel,
    required this.nit,
    required this.parqueoId,
    required this.estado,
    required this.horaInicio,
  });

  factory Reserva.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = (doc.data() as Map<String, dynamic>) ?? {};
    return Reserva(
      id: doc.id,
      nombreCompleto: data['nombreCompleto'] ?? '',
      placaVehiculo: data['placaVehiculo'] ?? '',
      horas: data['horas'] ?? 0,
      total: data['total']?.toDouble() ?? 0.0,
      numTel: data['numTel'] ?? '',
      nit: data['nit'] ?? '',
      parqueoId: data['parqueoId'] ?? '',
      estado: data['estado'] ?? 'pendiente',
      horaInicio: data['horaInicio'] ?? Timestamp.now(),
    );
  }
}

class _RecentState extends State<Recents> {
  List<Reserva> reservas = [];

  @override
  void initState() {
    super.initState();
    _obtenerReservas();
  }

  Future<List<String>> _obtenerIdsParqueosDelDueno(String ownerId) async {
    var parqueosSnapshot = await FirebaseFirestore.instance
        .collection('parqueosgp')
        .where('ownerId', isEqualTo: ownerId)
        .get();

    return parqueosSnapshot.docs.map((doc) => doc.id).toList();
  }

  void _obtenerReservas() async {
    String ownerId = FirebaseAuth.instance.currentUser!.uid;

    // Obtener los IDs de los parqueos del dueño
    List<String> idsParqueos = await _obtenerIdsParqueosDelDueno(ownerId);

    // Filtrar reservas que corresponden a esos parqueos
    var reservasSnapshot = await FirebaseFirestore.instance
        .collection('reservasgp')
        .where('parqueoId', whereIn: idsParqueos)
        .get();

    setState(() {
      reservas = reservasSnapshot.docs
          .map((doc) => Reserva.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas Recientes'),
        centerTitle: true,
        backgroundColor: Colors.black87, // Color del AppBar
      ),
      body: reservas.isEmpty
          ? Center(child: Text("No hay reservas disponibles"))
          : ListView.builder(
              itemCount: reservas.length,
              itemBuilder: (context, index) {
                Reserva reserva = reservas[index];
                String formattedDate = DateFormat('dd/MM/yyyy HH:mm')
                    .format(reserva.horaInicio.toDate());

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    title: Text(reserva.nombreCompleto,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${reserva.placaVehiculo} - $formattedDate"),
                    trailing: _buildTrailingButton(reserva),
                    onTap: () => _navegarADetalles(reserva),
                  ),
                );
              },
            ),
    );
  }

  void _navegarADetalles(Reserva reserva) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleReservaScreen(reserva: reserva),
      ),
    );
  }

  Widget _buildTrailingButton(Reserva reserva) {
    return ElevatedButton(
      onPressed: () => _cambiarEstadoReserva(reserva),
      child: Text(reserva.estado == 'pendiente' ? 'Iniciar' : 'Finalizar'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent, // Color del botón
      ),
    );
  }

  void _cambiarEstadoReserva(Reserva reserva) {
    // Cambiar el estado de la reserva en Firestore
    String nuevoEstado =
        reserva.estado == 'pendiente' ? 'en curso' : 'finalizada';
    FirebaseFirestore.instance
        .collection('reservasgp')
        .doc(reserva.id)
        .update({'estado': nuevoEstado})
        .then((_) => print('Estado actualizado'))
        .catchError((error) => print('Error al actualizar el estado: $error'));

    // Actualizar la UI
    setState(() {
      reserva.estado = nuevoEstado;
    });
  }
}
