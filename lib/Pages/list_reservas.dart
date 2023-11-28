import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:quickparking_flutter/Pages/reserva_model.dart';
import 'package:quickparking_flutter/Pages/booking_details.dart';

class ListaReservasCliente extends StatefulWidget {
  @override
  _ListaReservasClienteState createState() => _ListaReservasClienteState();
}

class _ListaReservasClienteState extends State<ListaReservasCliente> {
  List<Reserva> reservasCliente = [];

  @override
  void initState() {
    super.initState();
    _cargarReservas();
  }

  void _cargarReservas() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var reservasSnapshot = await FirebaseFirestore.instance
        .collection('reservasgp')
        .where('clienteId', isEqualTo: userId)
        .get();

    setState(() {
      reservasCliente = reservasSnapshot.docs
          .map((doc) => Reserva.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Reservas'),
        centerTitle: true,
        backgroundColor: Color(0xFFB71C1C),
      ),
      body: reservasCliente.isEmpty
          ? Center(child: Text("No tienes reservas"))
          : ListView.builder(
              itemCount: reservasCliente.length,
              itemBuilder: (context, index) {
                Reserva reserva = reservasCliente[index];
                String formattedDate = DateFormat('dd/MM/yyyy HH:mm')
                    .format(reserva.horaInicio.toDate());

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    title: Text(reserva.nombreCompleto,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${reserva.placaVehiculo} - $formattedDate"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalleReservaClienteScreen(reserva: reserva),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
