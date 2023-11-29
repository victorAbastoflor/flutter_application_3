/*import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/home/favorites_view.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondMenu.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 16, 5, 16),
                  padding: const EdgeInsets.all(5),
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
                                builder: (context) => const FavoritesScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.5)),
                        child: const Column(
                          children: [
                            Icon(Icons.favorite_border,
                                size: 48), // Icono grande
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
                        child: const Column(
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
                        child: const Column(
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
      ),
    );
  }
}
*/