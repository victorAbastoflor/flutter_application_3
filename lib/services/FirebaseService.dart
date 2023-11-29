import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/View/model/Parqueos.dart';

import '../View/model/Reservas.dart';

class FirebaseService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerPark(Parqueo parqueo) async {
    CollectionReference parqueosCollection = _firestore.collection('Parqueos');

    try {
      await parqueosCollection.add(parqueo.toMap());
      print('Parqueo registrado con éxito');
    } catch (e) {
      print('Error al registrar el parqueo: $e');
    }
  }

  Future<void> registerReservation(Reserva reserva) async {
    CollectionReference reservasCollection = _firestore.collection('Reservas');

    try {
      await reservasCollection.add(reserva.toMap());
      print('Reserva registrada con éxito');
    } catch (e) {
      print('Error al registrar la reserva: $e');
    }
  }

  Future<List<Object?>> getAllReservations(String usuario) async {
    try {
      // Get parqueos:
      QuerySnapshot parqueosQuerySnapshot = await _firestore.collection('Parqueos').where('Usuario', isEqualTo: usuario).get();
      List<Object?> parqueos = parqueosQuerySnapshot.docs.map((doc) => doc.data()).toList();
      List<Map<String, dynamic>> parqueosMap = List<Map<String, dynamic>>.from(parqueos);
      // add the document ID to the map:
      for (int i = 0; i < parqueos.length; i++) {
        parqueosMap[i]['id'] = parqueosQuerySnapshot.docs[i].id;
      }
      // Get reservas:
      QuerySnapshot reservasQuerySnapshot = await _firestore.collection('Reservas').where('Parqueos', isEqualTo: parqueosMap.first['Nombre']).get();
      List<Object?> reservas = reservasQuerySnapshot.docs.map((doc) => doc.data()).toList();
      List<Map<String, dynamic>> reservasMap = List<Map<String, dynamic>>.from(reservas);
      // add the document ID to the map:
      for (int i = 0; i < reservas.length; i++) {
        reservasMap[i]['id'] = reservasQuerySnapshot.docs[i].id;
      }
      return reservasMap;

      // return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error al obtener reservas: $e');
      return [];
    }
  }

  Future<void> actualizarEstadoLugar({required String lugarId, required bool nuevoEstado}) async {
    try {
      await _firestore.collection('Reservas').doc(lugarId).update({'Estado': nuevoEstado});
      print('Estado del lugar actualizado con éxito');
    } catch (e) {
      print('Error al actualizar el estado del lugar: $e');
    }
  }

  Future<void> incrementarContadorLugar({required String lugarId}) async {
    try {
      // Get the "parque name" from the "parqueoId":
      String parqueoName = '';
      DocumentSnapshot parqueoSnapshot = await _firestore.collection('Reservas').doc(lugarId).get();
      Map<String, dynamic> data = parqueoSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('Parqueos')) {
        parqueoName = data['Parqueos'];
      }
      // Get the "ParqueosId" from the "parqueoName":
      String parqueoId = '';
      QuerySnapshot parqueoQuerySnapshot = await _firestore.collection('Parqueos').where('Nombre', isEqualTo: parqueoName).get();
      if (parqueoQuerySnapshot.docs.isNotEmpty) {
        parqueoId = parqueoQuerySnapshot.docs.first.id;
      }
      await _firestore.collection('Parqueos').doc(parqueoId).update({'NumPlazas': FieldValue.increment(1)});
      print('Contador del lugar actualizado con éxito');
    } catch (e) {
      print('Error al actualizar el contador del lugar: $e');
    }
  }

  Future<void> decrementarContadorLugar({required String lugarId}) async {
    try {
      // Get the "parque name" from the "parqueoId":
      String parqueoName = '';
      DocumentSnapshot parqueoSnapshot = await _firestore.collection('Reservas').doc(lugarId).get();
      Map<String, dynamic> data = parqueoSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('Parqueos')) {
        parqueoName = data['Parqueos'];
      }
      // Get the "ParqueosId" from the "parqueoName":
      String parqueoId = '';
      QuerySnapshot parqueoQuerySnapshot = await _firestore.collection('Parqueos').where('Nombre', isEqualTo: parqueoName).get();
      if (parqueoQuerySnapshot.docs.isNotEmpty) {
        parqueoId = parqueoQuerySnapshot.docs.first.id;
      }
      await _firestore.collection('Parqueos').doc(parqueoId).update({'NumPlazas': FieldValue.increment(-1)});
      print('Contador del lugar actualizado con éxito');
    } catch (e) {
      print('Error al actualizar el contador del lugar: $e');
    }
  }

  Future<List<Object?>> getAdminApprovedReservations(String usuario) async {
    try {
      // Get parqueos:
      QuerySnapshot parqueosQuerySnapshot = await _firestore.collection('Parqueos').where('Usuario', isEqualTo: usuario).get();
      List<Object?> parqueos = parqueosQuerySnapshot.docs.map((doc) => doc.data()).toList();
      List<Map<String, dynamic>> parqueosMap = List<Map<String, dynamic>>.from(parqueos);
      // add the document ID to the map:
      for (int i = 0; i < parqueos.length; i++) {
        parqueosMap[i]['id'] = parqueosQuerySnapshot.docs[i].id;
      }
      // Get reservas:
      QuerySnapshot reservasQuerySnapshot =
          await _firestore.collection('Reservas').where('Parqueos', isEqualTo: parqueosMap.first['Nombre']).where('Estado', isEqualTo: true).get();
      List<Object?> reservas = reservasQuerySnapshot.docs.map((doc) => doc.data()).toList();
      List<Map<String, dynamic>> reservasMap = List<Map<String, dynamic>>.from(reservas);
      // add the document ID to the map:
      for (int i = 0; i < reservas.length; i++) {
        reservasMap[i]['id'] = reservasQuerySnapshot.docs[i].id;
      }
      return reservasMap;
      // return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error al obtener reservas: $e');
      return [];
    }
  }

  Future<List<Object?>> getClientApprovedReservations(String usuario) async {
    try {
      // Get reservas:
      QuerySnapshot reservasQuerySnapshot =
          await _firestore.collection('Reservas').where('Cliente', isEqualTo: usuario).where('Estado', isEqualTo: true).get();
      List<Object?> reservas = reservasQuerySnapshot.docs.map((doc) => doc.data()).toList();
      List<Map<String, dynamic>> reservasMap = List<Map<String, dynamic>>.from(reservas);
      // add the document ID to the map:
      for (int i = 0; i < reservas.length; i++) {
        reservasMap[i]['id'] = reservasQuerySnapshot.docs[i].id;
      }
      return reservasMap;
      // return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error al obtener reservas: $e');
      return [];
    }
  }
}
