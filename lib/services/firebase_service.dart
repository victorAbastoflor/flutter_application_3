import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/View/model/Parqueos.dart';
import 'package:flutter_application_3/View/model/Rol.dart';
import 'package:flutter_application_3/View/model/User.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


Future<List> getUser() async {
  List person = [];
  CollectionReference collectionReferencePersona = db.collection('Persona');
  QuerySnapshot queryPersona = await collectionReferencePersona.get();
  queryPersona.docs.forEach((documento) {
    person.add(documento.data());
  });
  return person;
}

// aqui optengo todo de la base de datos
Future<List> getFavorities() async {
  List favo = [];
  CollectionReference collectionReferenceFavorities =
      db.collection('Favorities');
  QuerySnapshot queryFavorities = await collectionReferenceFavorities.get();
  for (var documento in queryFavorities.docs) {
    favo.add(documento.data());
  }
  return favo;
}

Future<void> createUser(User user) async {
    CollectionReference users = db.collection('Usuario');
    try {
      await users.add(user.toMap());
      print('Usuario creado con éxito');
    } catch (e) {
      print('Error al crear usuario: $e');
    }
  }

Future<List<Rol>> getRoles() async {
  final rolesCollection = FirebaseFirestore.instance.collection('Rol');
  QuerySnapshot querySnapshot = await rolesCollection.get();
  return querySnapshot.docs
      .map((doc) => Rol.fromMap(doc.data() as Map<String, dynamic>))
      .toList();
}

Future<void> createPark(Parqueo parqueo) async {
  CollectionReference parqueos = FirebaseFirestore.instance.collection('Parqueos');
  try {
    await parqueos.add(parqueo.toMap());
    print('Parqueo registrado con éxito');
  } catch (e) {
    print('Error al registrar el parqueo: $e');
  }
}