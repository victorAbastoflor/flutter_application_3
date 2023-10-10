import 'package:flutter/material.dart';

import 'FavoritesScreen.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
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
                          MaterialPageRoute(
                              builder: (context) => FavoritesScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5)),
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
                          backgroundColor: Colors.black.withOpacity(0.5)),
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
                          backgroundColor: Colors.black.withOpacity(0.5)),
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
            ],
          ),
        ],
      ),
    );
  }
}
