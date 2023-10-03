/*import 'package:flutter/material.dart';

class ReservationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESERVAS'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background_image.png'), // Reemplaza con tu imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NOMBRE COMPLETO:',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: 'Ingresa tu nombre completo'),
                ),
                SizedBox(height: 10),
                Text(
                  'PLACA DE SU VEHÍCULO:',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Ingresa la placa de tu vehículo'),
                ),
                SizedBox(height: 10),
                Text(
                  'HORARIO DE LLEGADA Y SALIDA:',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Ingresa el horario de llegada y salida'),
                ),
                SizedBox(height: 20),
                Text(
                  'EL COSTO DE RESERVA ES DE Bs. 5',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Coloca aquí el widget del código QR (puede usar el QrImage del ejemplo anterior)
                QrImage(
                  data: 'AQUÍ_TU_DATO_PARA_EL_QR', // Reemplaza con tus datos
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Agrega aquí la lógica para escanear el código QR
                  },
                  child: Text(
                      'ESCANEE EL CÓDIGO QR CON UNA REFERENCIA DE SUS DATOS'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/