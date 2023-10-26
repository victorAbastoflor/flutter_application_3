import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/firebase_service.dart';

class ListParqueoScreen extends StatefulWidget {
  @override
  _ListParqueoScreenState createState() => _ListParqueoScreenState();
}

class _ListParqueoScreenState extends State<ListParqueoScreen> {
  List<Map<String, dynamic>> parqueos = [];

  @override
  void initState() {
    super.initState();
    getParqueos().then((parqueosData) {
      setState(() {
        parqueos = parqueosData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Parqueos'),
      ),
      body: ListView.builder(
        itemCount: parqueos.length,
        itemBuilder: (context, index) {
          final parqueo = parqueos[index];
          return ListTile(
            title: Text(parqueo['nombre']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Dirección: ${parqueo['direccion']}'),
                Text('Número de Plazas: ${parqueo['numPlazas']}'),
                Text('Hora de Apertura: ${parqueo['Hora.Apertura']}'),
                Text('Tipo de Vehículo: ${parqueo['TipoVehiculo'].join(', ')}'),
                Text('Latitud: ${parqueo['latitud']}'),
                Text('Longitud: ${parqueo['longitud']}'),
              ],
            ),
            // Puedes personalizar la apariencia y detalles del ListTile según tus datos
          );
        },
      ),
    );
  }
}
