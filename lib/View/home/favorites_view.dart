import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/home/home_view.dart';
import 'package:flutter_application_3/services/firebase_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchData() async {
    final data = await getFavorities(); // Llama a tu función asincrónica aquí
    return List<Map<String, dynamic>>.from(
        data); // Convierte los datos al tipo esperado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondMenu.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error al cargar datos: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No hay datos disponibles'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final lugar = snapshot.data![index];
                    return buildFavoriteItem(lugar);
                  },
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius:
                    BorderRadius.circular(12.0), // Esquinas redondeadas
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFavoriteItem(Map<String, dynamic> lugar) {
    // Esta función crea un elemento de lugar favorito
    final nombre = lugar['nombre'];

    return ListTile(
      title: Text(
        nombre,
        style: const TextStyle(
          color: Colors.white, // Color blanco
          fontWeight: FontWeight.bold, // Texto en negrita
          fontSize: 18, // Tamaño de fuente
        ),
      ),
      // Puedes personalizar cómo se muestra cada lugar favorito aquí
    );
  }
}
