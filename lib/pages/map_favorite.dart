import 'package:flutter/material.dart';

class Parqueo {
  final String nombre;
  final String direccion;
  final double calificacion;

  Parqueo({
    required this.nombre,
    required this.direccion,
    required this.calificacion,
  });
}

class map_favorite extends StatefulWidget {
  const map_favorite({Key? key}) : super(key: key);

  @override
  _map_favorite createState() => _map_favorite();
}

class _map_favorite extends State<map_favorite> {
  List<Parqueo> parqueosFavoritos = [
    Parqueo(
        nombre: "Parqueo San Pedro",
        direccion: "Av. San Martin",
        calificacion: 4.5),
    Parqueo(nombre: "Parqueo 2", direccion: "Dirección 2", calificacion: 4.0),
    // Agrega más parqueos favoritos según tus necesidades
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parqueos Favoritos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
        mainAxisAlignment:
            MainAxisAlignment.start, // Alinea en la parte superior
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Parqueos Favoritos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: parqueosFavoritos.length,
              itemBuilder: (context, index) {
                final parqueo = parqueosFavoritos[index];
                return ListTile(
                  title: Text(parqueo.nombre),
                  subtitle: Text(parqueo.direccion),
                  trailing: Text(
                    'Calificación: ${parqueo.calificacion.toStringAsFixed(1)}',
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
