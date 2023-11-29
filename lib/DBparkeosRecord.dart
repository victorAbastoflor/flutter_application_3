import 'package:cloud_firestore/cloud_firestore.dart';

class DBparkeosRecord {
  final String direccion;
  final String image;
  final GeoPoint latitudlongitud;
  final String nombre;
  final int numplazas;
  final double precio;
  final int tipoVehiculo;

  DBparkeosRecord({
    required this.direccion,
    required this.image,
    required this.latitudlongitud,
    required this.nombre,
    required this.numplazas,
    required this.precio,
    required this.tipoVehiculo,
  });

  static Future<DBparkeosRecord> getDocument(
      DocumentReference reference) async {
    final documentSnapshot = await reference.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return DBparkeosRecord(
      direccion: data['direccion'],
      image: data['image'],
      latitudlongitud: data['latitudlongitud'],
      nombre: data['nombre'],
      numplazas: data['numplazas'],
      precio: data['precio'],
      tipoVehiculo: data['tipoVehiculo'],
    );
  }
}
