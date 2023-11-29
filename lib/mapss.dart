import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/model/LoggedInUser.dart';
import 'package:flutter_application_3/View/model/Parqueos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/View/model/Reservas.dart';
import 'package:flutter_application_3/services/FirebaseService.dart';

class MapViewLoad extends StatefulWidget {
  final LoggedInUser loggedInUser; 
  MapViewLoad({required this.loggedInUser});

  @override
  _MapViewState createState() => _MapViewState();
}


class _MapViewState extends State<MapViewLoad> {
  List<Parqueo> _parqueosList = [];

  @override
  void initState() {
    super.initState();
    _loadParqueos(); // Llama a la función para cargar los parqueos
  }

  void _loadParqueos() async {
    try {
      CollectionReference parqueosCollection =
          FirebaseFirestore.instance.collection('Parqueos');
      QuerySnapshot querySnapshot = await parqueosCollection.get();

      List<Parqueo> parqueos = querySnapshot.docs
          .map((doc) => Parqueo.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      setState(() {
        _parqueosList = parqueos;
      });
    } catch (e) {
      print('Error al cargar parqueos: $e');
    }
  }

  void _showCustomWidget(Parqueo parqueo, LoggedInUser user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: 350,
          height: 220,
          decoration: BoxDecoration(
            color: Color.fromARGB(181, 0, 0, 0),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Reserva para ${parqueo.nombre}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReservationForm(parqueo, user.nombre),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF651A1A),
                    textStyle: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 14,
                    ),
                  ),
                  child: Text('Reservar ahora'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _parqueosList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_parqueosList[index].nombre),
                    subtitle: Text(_parqueosList[index].direccion),
                    onTap: () {
                      _showCustomWidget(
                          _parqueosList[index], widget.loggedInUser);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationForm extends StatelessWidget {
  final Parqueo parqueo;
  final String nombreCliente;

  ReservationForm(this.parqueo, this.nombreCliente);

  final TextEditingController placaController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Reserva \n para ${parqueo.nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Completa el formulario de reserva para ${parqueo.nombre}.'),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre del Parqueo'),
              initialValue: parqueo.nombre,
              readOnly: true,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre del Cliente'),
              initialValue: nombreCliente,
              readOnly: true,
            ),
            TextFormField(
              controller: placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            TextFormField(
              controller: telefonoController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Reservar'),
            ),
          ],
        ),
      ),
    );
  }

 void _submitForm() {
    String placa = placaController.text;
    String telefono = telefonoController.text;

    Reserva reserva = Reserva(
      cliente: nombreCliente,
      costo: 0.0, 
      estado: false,
      horaInicio: DateTime.now(),
      tiempoTranscurrido: '',
      parqueos: parqueo.nombre,
      placa: placa,
      telefono: telefono,
    );

    FirebaseService().registerReservation(reserva);

    placaController.clear();
    telefonoController.clear();
  }
}
