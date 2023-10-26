/*import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/firebase_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Map<String, dynamic>> parqueos = [];

  @override
  void initState() {
    super.initState();
    _loadParqueos();
  }

  Future<void> _loadParqueos() async {
    final parqueosData = await getParqueo();
    setState(() {
      parqueos = parqueosData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Parqueos'),
      ),
      body: GoogleMap(
        markers: _buildMarkers(),
        // Configuración del mapa, como la ubicación inicial y los controles.
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    return parqueos.map((parqueo) {
      final lat = parqueo['latitud'];
      final lng = parqueo['longitud'];

      return Marker(
        markerId: MarkerId(parqueo['uid']),
        position: LatLng(lat, lng),
        onTap: () {
          // Mostrar detalles del parqueo cuando se hace clic en el marcador.
          _showParqueoDetails(context, parqueo);
        },
      );
    }).toSet();
  }

  void _showParqueoDetails(BuildContext context, Map<String, dynamic> parqueo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del parqueo'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${parqueo['nombre']}'),
              Text('Tipo de vehículo: ${parqueo['c_tipovehiculo']}'),
              Text('Horario de apertura: ${parqueo['d_horarioapertura']}'),
              // Agrega más detalles según tu base de datos.
            ],
          ),
          actions: [
            FlatButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}*/
