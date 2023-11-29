import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/model/LoggedInUser.dart';
import 'package:flutter_application_3/services/FirebaseService.dart';

class ProfileWidget extends StatelessWidget {
  final LoggedInUser user;

  ProfileWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Colors.white70,
      fontSize: 20, // Tamaño más grande para la letra
      fontWeight: FontWeight.bold, // Letra en negrita para darle importancia
    );

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Alinea verticalmente al centro
        crossAxisAlignment: CrossAxisAlignment.center, // Alinea horizontalmente al centro
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos del Row
            children: [
              Icon(Icons.person, color: Colors.white70), // Icono de usuario
              SizedBox(width: 8), // Espacio entre el icono y el texto
              Text('Nombre: ${user.nombre}', style: textStyle),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle, color: Colors.white70),
              SizedBox(width: 8),
              Text('Usuario: ${user.usuario}', style: textStyle),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, color: Colors.white70), // Icono de seguridad o rol
              SizedBox(width: 8),
              Text('Rol: ${user.tipoRol}', style: textStyle),
            ],
          ),
          // child scroll view to get the aproved reservations:
          SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: (user.tipoRol == 'Cliente') ? fetchClientApprovedReservations() : fetchAdminApprovedReservations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar datos: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No hay reservas aprobadas'));
                } else {
                  final reservas = snapshot.data!;
                  return ListView.builder(
                    itemCount: reservas.length,
                    itemBuilder: (context, index) {
                      final reserva = reservas[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cliente: ${reserva['Cliente']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              // Resto de los datos del cliente según tus necesidades
                              SizedBox(height: 8),
                              Text(
                                'Parqueo: ${reserva['Parqueos']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              // Resto de los datos del parqueo según tus necesidades
                              SizedBox(height: 8),
                              Text(
                                'Fecha: ${reserva['Hora de Inicio'].split('T')[0].split('-').reversed.join('/')}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              // Resto de los datos de la reserva según tus necesidades
                              SizedBox(height: 8),
                              Text(
                                'Estado: ${reserva['Estado'] ? 'Aprobado' : 'Pendiente'}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              // Resto de los datos de la reserva según tus necesidades
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchAdminApprovedReservations() async {
    try {
      final data = await FirebaseService().getAdminApprovedReservations(user.usuario);
      print('Reservas obtenidas con éxito: $data');
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error al obtener reservas: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchClientApprovedReservations() async {
    try {
      final data = await FirebaseService().getClientApprovedReservations(user.usuario);
      print('Reservas obtenidas con éxito: $data');
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error al obtener reservas: $e');
      return [];
    }
  }
}
