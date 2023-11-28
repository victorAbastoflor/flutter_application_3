import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickparking_flutter/Transitions/ScaleTransition.dart';
import 'package:quickparking_flutter/Pages/recipt.dart';
import 'package:quickparking_flutter/Pages/recipt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickparking_flutter/Pages/recipt_client.dart';
import 'package:quickparking_flutter/Pages/reserva_model.dart';

class MyPaymentPage extends StatefulWidget {
  final Map<String, dynamic> parqueoData;

  MyPaymentPage({required this.parqueoData}) {
    print("ParqueoData recibido en MyFormPage: $parqueoData");
    print("ParqueoId directo en constructor: ${parqueoData['parqueoId']}");
  }
  @override
  State createState() => _MyPaymentPageState();
}

class _MyPaymentPageState extends State<MyPaymentPage> {
  Map<String, dynamic> datosReserva = {};
  final _formKey = GlobalKey<FormState>();

  int _horas = 0;

  TextEditingController _placaVehiculoController = TextEditingController();
  TextEditingController _nombreCompletoController = TextEditingController();
  TextEditingController _horasController = TextEditingController();
  TextEditingController _cellphoneController = TextEditingController();
  TextEditingController _numnitController = TextEditingController();

  double _total = 0.0;
  int espaciosDisponibles = 0;
  int _cellphone = 0;
  int _numnit = 0;

  @override
  void initState() {
    super.initState();
    _horasController.addListener(_updateTotal);
    espaciosDisponibles = widget.parqueoData['espaciosDisponibles'];
  }

  @override
  void dispose() {
    _horasController.removeListener(_updateTotal);
    _horasController.dispose();
    super.dispose();
  }

  void _updateTotal() {
    double costoPorHora = widget.parqueoData['horaCosto'];
    setState(() {
      int horas = int.tryParse(_horasController.text) ?? 0;
      _total = horas * costoPorHora;
    });
  }

  void _openPaymentPage(Map<String, dynamic> parqueoData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyPaymentPage(parqueoData: parqueoData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double costoPorHora = widget.parqueoData['horaCosto'] ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  widget.parqueoData['nombre'],
                  style: TextStyle(
                    fontSize: 34.4,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  widget.parqueoData['ubicacion'],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 74),
                TextFormField(
                  controller: _nombreCompletoController,
                  decoration: InputDecoration(labelText: 'Nombre Completo'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su nombre completo' : null,
                ),
                TextFormField(
                  controller: _cellphoneController,
                  decoration: InputDecoration(labelText: 'Número de Celular'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su número de celular' : null,
                ),
                TextFormField(
                  controller: _numnitController,
                  decoration: InputDecoration(labelText: 'NIT o CI'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su NIT o CI' : null,
                ),
                TextFormField(
                  controller: _placaVehiculoController,
                  decoration: InputDecoration(labelText: 'Placa del Vehículo'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese la placa de su vehículo' : null,
                ),
                TextFormField(
                  controller: _horasController,
                  decoration:
                      InputDecoration(labelText: 'Horas (estacionamiento)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Ingrese las horas de estacionamiento';
                    if (int.tryParse(value) == null)
                      return 'Ingrese un número válido';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Total a Pagar: \$${_total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _tryToReserve(),
                  child: Text('RESERVA AHORA'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black87,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    elevation: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tryToReserve() {
    if (espaciosDisponibles <= 0) {
      _showNoSpaceAvailableDialog();
    } else {
      _submitReserva();
    }
  }

  void _submitReserva() {
    //parqueoId
    String? parqueoId = widget.parqueoData['parqueoId'];
    String clientId = FirebaseAuth.instance.currentUser!.uid;
    print('UID del usuario actual: $clientId');
    print("ParqueoData en MyFormPage: ${widget.parqueoData}");
    print("ParqueoId: $parqueoId");

    if (parqueoId == null) {
      print('Error: parqueoId es null');
      // Considera mostrar un mensaje de error en la interfaz de usuario aquí
      return;
    }

    //clienteId
    if (_formKey.currentState!.validate()) {
      // Crear objeto de reserva
      var reserva = {
        'nombreCompleto': _nombreCompletoController.text,
        'placaVehiculo': _placaVehiculoController.text,
        'horas': int.tryParse(_horasController.text) ?? 0,
        'total': _total,
        'numTel': _cellphoneController.text,
        'nit': _numnitController.text,
        'parqueoId': parqueoId,
        'clienteId': clientId,
        'estado': 'pendiente',
        'horaInicio': FieldValue.serverTimestamp(),
      };

      String direccionParqueo =
          widget.parqueoData['ubicacion'] ?? 'Dirección no disponible';

      FirebaseFirestore.instance
          .collection('usuariosgp')
          .doc(clientId)
          .get()
          .then((usuarioDoc) {
        String rolUsuario = usuarioDoc.data()?['rol'] ?? '';

        FirebaseFirestore.instance
            .collection('reservasgp')
            .add(reserva)
            .then((docRef) {
          print('Reserva realizada con ID: ${docRef.id}');

          Reserva reservaObj = Reserva(
            id: docRef.id,
            nombreCompleto: _nombreCompletoController.text,
            placaVehiculo: _placaVehiculoController.text,
            horas: int.tryParse(_horasController.text) ?? 0,
            total: _total,
            numTel: _cellphoneController.text,
            nit: _numnitController.text,
            parqueoId: parqueoId,
            clienteId: clientId,
            estado: 'pendiente',
            horaInicio: Timestamp.now(),
            ubicacion: direccionParqueo,
          );

          Map<String, dynamic> reservaData = {
            'nombreCompleto': _nombreCompletoController.text,
            'numTel': _cellphoneController.text,
            'nit': _numnitController.text,
            'placaVehiculo': _placaVehiculoController.text,
            'horas': int.tryParse(_horasController.text) ?? 0,
            'total': _total.toStringAsFixed(2),
            'ubicacion': direccionParqueo,
            'parqueoId': parqueoId,
            'id': clientId,
            'reservaId': docRef.id,
          };

          print('Datos de la reserva: $reservaData');

          if (rolUsuario == 'Cliente') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReciboScreen(reserva: reservaObj)),
            );
          } else if (rolUsuario == 'Dueño') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyRecipt(reservaData: reservaData)),
            );
          } else {}
        }).catchError((error) {});
      });
    }
  }

  void _showNoSpaceAvailableDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Hay Espacios Disponibles"),
          content:
              Text("Lo sentimos, este parqueo está completamente ocupado."),
          actions: <Widget>[
            TextButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
