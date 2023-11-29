import 'package:flutter/foundation.dart';

class Parqueo {
  final String usuario;
  final String direccion;
  final String horaApertura;
  final String nombre;
  final int numPlazas;
  final List<String> tipoVehiculo;

  Parqueo({
    required this.usuario,
    required this.direccion,
    required this.horaApertura,
    required this.nombre,
    required this.numPlazas,
    required this.tipoVehiculo,
  });

  // Método para crear una instancia de Parqueo desde un Map. Útil para la deserialización desde Firebase.
  factory Parqueo.fromMap(Map<String, dynamic> map) {
    return Parqueo(
      usuario: map['Usuario'] ?? '',
      direccion: map['Direccion'] ?? '',
      horaApertura: map['HoraApertura'] ?? '',
      nombre: map['Nombre'] ?? '',
      numPlazas: map['NumPlazas']?.toInt() ?? 0,
      tipoVehiculo: List<String>.from(map['TipoVehiculo'] ?? []),
    );
  }

  // Método para convertir el objeto Parqueo en un Map. Útil para la serialización a Firebase.
  Map<String, dynamic> toMap() {
    return {
      'Usuario': usuario,
      'Direccion': direccion,
      'HoraApertura': horaApertura,
      'Nombre': nombre,
      'NumPlazas': numPlazas,
      'TipoVehiculo': tipoVehiculo,
    };
  }
}
