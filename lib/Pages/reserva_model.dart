import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Reserva {
  String id;
  String nombreCompleto;
  String placaVehiculo;
  int horas;
  double total;
  String numTel;
  String ubicacion;
  String clienteId;

  String nit;
  String parqueoId;
  String estado;
  Timestamp horaInicio;

  Reserva({
    required this.id,
    required this.nombreCompleto,
    required this.placaVehiculo,
    required this.horas,
    required this.clienteId,
    required this.total,
    required this.numTel,
    required this.nit,
    required this.parqueoId,
    required this.estado,
    required this.horaInicio,
    required this.ubicacion,
  });
  factory Reserva.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = (doc.data() as Map<String, dynamic>) ?? {};
    print('Cargando datos de reserva: $data');

    return Reserva(
      id: doc.id,
      clienteId: data['id'] ?? '',
      nombreCompleto: data['nombreCompleto'] ?? '',
      placaVehiculo: data['placaVehiculo'] ?? '',
      horas: data['horas'] ?? 0,
      total: data['total']?.toDouble() ?? 0.0,
      numTel: data['numTel'] ?? '',
      nit: data['nit'] ?? '',
      parqueoId: data['parqueoId'] ?? '',
      estado: data['estado'] ?? 'pendiente',
      horaInicio: data['horaInicio'] ?? Timestamp.now(),
      ubicacion: data['ubicacion'] ?? '',
    );
  }
}
