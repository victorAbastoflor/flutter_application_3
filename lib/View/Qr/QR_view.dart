import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  final String qrData = "TuTextoAqui"; // Puedes reemplazar esto con tus datos
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();

  QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESERVAS'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/fondRegist.png'), // Reemplaza con tu imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'NOMBRE COMPLETO:',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  TextFormField(
                    controller: nombreController,
                    style: const TextStyle(
                        color: Colors
                            .white), // Cambia el color del texto ingresado a blanco
                    decoration: const InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(
                          color: Colors
                              .white), // Cambia el color del texto de sugerencia a blanco
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'PLACA DE SU VEHÍCULO:',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  TextFormField(
                    controller: placaController,
                    style: const TextStyle(
                        color: Colors
                            .white), // Cambia el color del texto ingresado a blanco
                    decoration: const InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(
                          color: Colors
                              .white), // Cambia el color del texto de sugerencia a blanco
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'HORARIO DE LLEGADA Y SALIDA:',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  TextFormField(
                    controller: horarioController,
                    style: const TextStyle(
                        color: Colors
                            .white), // Cambia el color del texto ingresado a blanco
                    decoration: const InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(
                          color: Colors
                              .white), // Cambia el color del texto de sugerencia a blanco
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'EL COSTO DE RESERVA ES DE Bs. 5',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  // Coloca aquí el widget del código QR (puede usar el QrImage del ejemplo anterior)
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: QrImageView(
                      data: qrData, // Reemplaza con tus datos
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Obtén los valores de los campos de texto
                      final nombre = nombreController.text;
                      final placa = placaController.text;
                      final horario = horarioController.text;

                      // Genera el código QR basado en los datos ingresados
                      final qrData = generateQRData(nombre, placa, horario);

                      // Verifica si el código QR ya existe en Firestore
                      final qrCodesCollection =
                          FirebaseFirestore.instance.collection('qr_codes');
                      final querySnapshot = await qrCodesCollection
                          .where('qrData', isEqualTo: qrData)
                          .get();

                      if (querySnapshot.docs.isEmpty) {
                        // El código QR no existe en la base de datos, puedes guardarlo
                        await qrCodesCollection.add({'qrData': qrData});

                        // Luego, guarda los otros datos en Firestore, por ejemplo, en una colección 'reservas'
                        final reservasCollection =
                            FirebaseFirestore.instance.collection('reservas');
                        await reservasCollection.add({
                          'nombre': nombre,
                          'placa': placa,
                          'horario': horario,
                          // Agrega otros campos de reserva aquí según tu modelo de datos
                        });

                        // Limpia los campos de texto después de guardar
                        nombreController.clear();
                        placaController.clear();
                        horarioController.clear();

                        // Puedes mostrar un mensaje de éxito o redirigir al usuario a otra pantalla
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Reserva guardada con éxito')),
                        );
                      } else {
                        // El código QR ya existe en la base de datos, muestra un mensaje de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'El código QR ya existe en la base de datos')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Guardar Reserva'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String generateQRData(String nombre, String placa, String horario) {
    return '$nombre-$placa-$horario'; // Puedes personalizar este formato según tus necesidades
  }
}
