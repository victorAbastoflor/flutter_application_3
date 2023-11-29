import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'owner_parkingpage.dart';

final CollectionReference owner =
    FirebaseFirestore.instance.collection('Dueño');

class OwnerRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Registro del dueño'),
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
            OwnerRegisterForm(),
          ],
        ),
      ),
    );
  }
}

class OwnerRegisterForm extends StatefulWidget {
  @override
  _OwnerRegisterFormState createState() => _OwnerRegisterFormState();
}

class _OwnerRegisterFormState extends State<OwnerRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _carnetController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _nombreController,
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
            controller: _carnetController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Carnet de Identidad',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce tu carnet de identidad';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _fechaNacimientoController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Fecha de nacimiento',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce tu fecha de nacimiento';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _telefonoController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Número de teléfono',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce tu número de teléfono';
              }
              return null;
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Guarda los datos del formulario en Firestore
                owner.add({
                  'a_nombrecompleto': _nombreController.text,
                  'b_carnet': _carnetController.text,
                  'c_fechanacimiento': _fechaNacimientoController.text,
                  'd_numerotel': _telefonoController.text,
                }).then((value) {
                  print("User Added");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuario agregado con éxito')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParkingRegisterPage()),
                  );
                }).catchError((error) {
                  print("Failed to add user: $error");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al agregar usuario')),
                  );
                });
              }
            },
            child: Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}
