import 'package:flutter/foundation.dart';

class Reserva {
  final String cliente;
  final double costo;
  final bool estado;
  final DateTime horaInicio;
  final String tiempoTranscurrido;
  final String parqueos;
  final String placa;
  final String telefono;

  Reserva({
    required this.cliente,
    required this.costo,
    required this.estado,
    required this.horaInicio,
    required this.tiempoTranscurrido,
    required this.parqueos,
    required this.placa,
    required this.telefono,
  });

  factory Reserva.fromMap(Map<String, dynamic> map) {
    return Reserva(
      cliente: map['Cliente'] ?? '',
      costo: (map['Costo']?.toDouble()) ?? 0.0,
      estado: map['Estado'] ?? false,
      horaInicio: DateTime.parse(map['Hora de Inicio']),
      tiempoTranscurrido: map['Tiempo Transcurrido'] ?? '',
      parqueos: map['Parqueos'] ?? '',
      placa: map['Placa'] ?? '',
      telefono: map['Telefono'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Cliente': cliente,
      'Costo': costo,
      'Estado': estado,
      'Hora de Inicio': horaInicio.toIso8601String(),
      'Tiempo Transcurrido': tiempoTranscurrido,
      'Parqueos': parqueos,
      'Placa': placa,
      'Telefono': telefono,
    };
  }
}
