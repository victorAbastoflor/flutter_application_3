import 'package:flutter/material.dart';
import 'owner_loginpage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference owner =
    FirebaseFirestore.instance.collection('Parqueo');

class ParkingRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Registro del parqueo'),
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
            ParkingRegisterForm(),
          ],
        ),
      ),
    );
  }
}

class ParkingRegisterForm extends StatefulWidget {
  @override
  _ParkingRegisterFormState createState() => _ParkingRegisterFormState();
}

class _ParkingRegisterFormState extends State<ParkingRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _time = TimeOfDay.now();
  final _parkingNameController = TextEditingController();
  final _parkingLocationController = TextEditingController();
  List<String> _vehicleTypes = ['Carro', 'Moto', 'Bicicleta'];
  Map<String, bool> _vehicleTypeSelection = {
    'Carro': false,
    'Moto': false,
    'Bicicleta': false,
  };

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _parkingNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nombre del parqueo',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce el nombre del parqueo';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _parkingLocationController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Ubicación del parqueo',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce la ubicación del parqueo';
              }
              return null;
            },
          ),
          ..._vehicleTypes.map((String vehicleType) {
            return CheckboxListTile(
              title: Text(vehicleType),
              value: _vehicleTypeSelection[vehicleType],
              onChanged: (bool? newValue) {
                setState(() {
                  _vehicleTypeSelection[vehicleType] = newValue!;
                });
              },
            );
          }).toList(),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text('Selecciona el horario de apertura'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                List<String> selectedVehicleTypes = _vehicleTypeSelection
                    .entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();
                owner.add({
                  'a_nombreparqueo': _parkingNameController.text,
                  'b_ubicacion': _parkingLocationController.text,
                  'c_tipovehiculo': selectedVehicleTypes,
                  'd_horarioap': _time.format(context),
                  // Agrega los demás campos aquí
                }).then((value) {
                  print("User Added");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }).catchError((error) {
                  print("Failed to add user: $error");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al agregar usuario')),
                  );
                });
              }
            },
            child: Text('Registrar'),
          ),
        ],
      ),
    );
  }
}
