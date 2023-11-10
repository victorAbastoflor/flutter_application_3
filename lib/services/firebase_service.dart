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
