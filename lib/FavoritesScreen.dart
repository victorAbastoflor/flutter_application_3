import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/firebase_service.dart';
import 'Home.dart';

class FavoritesScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchData() async {
    final data = await getFavorities(); // Llama a tu función asincrónica aquí
    return List<Map<String, dynamic>>.from(
        data); // Convierte los datos al tipo esperado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Favoritos'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BackgroundF.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error al cargar datos: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
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
              margin: EdgeInsets.fromLTRB(5, 16, 5, 16),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius:
                    BorderRadius.circular(12.0), // Esquinas redondeadas
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.favorite_border, size: 48), // Icono grande
                        Text(
                          'Favoritos',
                          style: TextStyle(fontSize: 14), // Texto pequeño
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción cuando se presiona el botón "Mapa"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.map, size: 48), // Icono grande
                        Text(
                          'Mapa',
                          style: TextStyle(fontSize: 14), // Texto pequeño
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción cuando se presiona el botón "Cerrar Sesión"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.logout, size: 48), // Icono grande
                        Text(
                          'Cerrar Sesión',
                          style: TextStyle(fontSize: 14), // Texto pequeño
                        ),
                      ],
                    ),
                  ),
                ],
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
        style: TextStyle(
          color: Colors.white, // Color blanco
          fontWeight: FontWeight.bold, // Texto en negrita
          fontSize: 18, // Tamaño de fuente
        ),
      ),
      // Puedes personalizar cómo se muestra cada lugar favorito aquí
    );
  }
}
