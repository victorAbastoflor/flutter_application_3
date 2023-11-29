import 'package:flutter/material.dart';
import 'package:flutter_application_3/owner-all/owner_loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference reservations =
    FirebaseFirestore.instance.collection('usuario_Reservas');

class ReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Reservas'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ReservationForm(),
      ),
    );
  }
}

class ReservationForm extends StatefulWidget {
  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _vehiclePlateController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _departureTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Aquí van tus TextFormFields
          TextFormField(
            controller: _fullNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nombre completo',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce tu nombre completo';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _vehiclePlateController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Placa de su vehículo',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce la placa de tu vehículo';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _arrivalTimeController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Por favor, pon tu horario de llegada',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce tu nombre completo';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _departureTimeController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Por favor, pon tu horario de salida',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, pon tu horario de salida';
              }
              return null;
            },
          ),
          // Aquí van los demás TextFormFields
          // Cuando estés listo para enviar los datos a Firestore:
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Guarda los datos del formulario en Firestore
                reservations.add({
                  'a_nombrecompleto': _fullNameController.text,
                  'b_placavehiculo': _vehiclePlateController.text,
                  'c_horallegada': _arrivalTimeController.text,
                  'd_horasalida': _departureTimeController.text,
                  // Agrega los demás campos aquí
                }).then((value) {
                  print("Book Added");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }).catchError((error) {
                  print("Failed to add the reserve: $error");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al agregar la reserva')),
                  );
                });
              }
            },
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
