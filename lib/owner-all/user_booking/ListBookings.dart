import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference reservations =
    FirebaseFirestore.instance.collection('usuario_Reservas');

class ListBookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Lista de Reservas'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ReservationsList(),
      ),
    );
  }
}

class ReservationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: reservations.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo salió mal');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Cargando...");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['a_nombrecompleto'],
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                  'Placa del vehículo: ${data['b_placavehiculo']}\nHora de llegada: ${data['c_horallegada']}\nHora de salida: ${data['d_horasalida']}',
                  style: TextStyle(color: Colors.white)),
              tileColor: Colors.grey[900],
            );
          }).toList(),
        );
      },
    );
  }
}
