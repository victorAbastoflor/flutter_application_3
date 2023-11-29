import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/model/LoggedInUser.dart';
import 'package:flutter_application_3/services/FirebaseService.dart';
import 'package:flutter_application_3/services/firebase_service.dart';

class FavoritesScreen extends StatelessWidget {
  final LoggedInUser? loggedInUser;

  const FavoritesScreen({Key? key, this.loggedInUser}) : super(key: key);

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
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    if (loggedInUser == null) {
      return []; // No hay información válida del dueño del parqueo
    }
    try {
      final data = await FirebaseService().getAllReservations(loggedInUser!.nombre!);
      print('Reservas obtenidas con éxito: $data');
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error al obtener reservas: $e');
      return [];
    }
  }

  Widget buildFavoriteItem(Map<String, dynamic> lugar) {
    final cliente = lugar['Cliente'];
    bool estado = lugar['Estado'] ?? false;

    if (cliente is String) {
      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cliente: $cliente',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Más datos:',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Costo: ${lugar['Costo'] ?? 'No disponible'}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                'Hora de Inicio: ${lugar['Hora de Inicio'] ?? 'No disponible'}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                'Parqueo: ${lugar['Parqueos'] ?? 'No disponible'}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                'Teléfono: ${lugar['Telefono'] ?? 'No disponible'}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                'Placa: ${lugar['Placa'] ?? 'No disponible'}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                'Estado: ${estado ? 'Ocupado' : 'Libre'}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      actualizarEstadoLugar(lugar);
                    },
                    child: Text(estado ? 'Liberar' : 'Confirmar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (cliente is DocumentReference) {
      return FutureBuilder<DocumentSnapshot>(
        future: cliente.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error al cargar datos: ${snapshot.error}'),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Cliente Desconocido'),
              ),
            );
          } else {
            final clienteData = snapshot.data!.data();
            if (clienteData != null && clienteData is Map<String, dynamic>) {
              final clienteNombre = clienteData['nombre'] as String? ?? 'Cliente Desconocido';
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cliente: $clienteNombre',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      // Resto de los datos del cliente según tus necesidades
                    ],
                  ),
                ),
              );
            } else {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Cliente Desconocido'),
                ),
              );
            }
          }
        },
      );
    } else {
      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Cliente Desconocido'),
        ),
      );
    }
  }

  void actualizarEstadoLugar(Map<String, dynamic> lugar) async {
    try {
      bool nuevoEstado = !(lugar['Estado'] ?? false);
      await FirebaseService().actualizarEstadoLugar(lugarId: lugar['id'], nuevoEstado: nuevoEstado);
      if (!nuevoEstado) {
        await FirebaseService().incrementarContadorLugar(lugarId: lugar['id']);
      } else {
        await FirebaseService().decrementarContadorLugar(lugarId: lugar['id']);
      }
      // Refrescar la pantalla o realizar otras acciones necesarias después de la actualización.
    } catch (e) {
      print('Error al actualizar el estado: $e');
    }
  }
}
