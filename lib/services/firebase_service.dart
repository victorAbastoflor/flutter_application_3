import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
//funcion
Future<List> getPersona() async {
  List person = [];
  CollectionReference collectionReferencePersona = db.collection('Persona');
  QuerySnapshot queryPersona = await collectionReferencePersona.get();
  queryPersona.docs.forEach((documento) {
    person.add(documento.data());
  });
  return person;
}
