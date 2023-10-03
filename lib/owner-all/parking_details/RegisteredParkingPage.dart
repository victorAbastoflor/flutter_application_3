import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference parking =
    FirebaseFirestore.instance.collection('Parqueo');

class RegisteredParkingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Parqueos Registrados'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: FlutterLogo(size: 150),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: parking.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Algo salió mal');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Cargando...");
                }

                return Expanded(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Card(
                        color: Colors.red[900],
                        elevation: 8,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading:
                              Icon(Icons.local_parking, color: Colors.white),
                          title: Text(
                            data['a_nombreparqueo'] ?? 'Sin nombre',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data['b_ubicacion'] ?? 'Sin ubicación',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                              Text(
                                'Tipos de Vehículos admitidos: ' +
                                    (data['c_tipovehiculo'] is List
                                        ? (data['c_tipovehiculo'] as List)
                                            .join(', ')
                                        : 'No especificado'),
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                              Text(
                                data['d_horarioap'] ?? 'Sin horario',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
