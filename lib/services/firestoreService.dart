import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/View/model/Persona_model.dart';

class FirestoreService {
  final CollectionReference personasCollection =
      FirebaseFirestore.instance.collection('Persona');

  Future<void> addPersona(Persona persona) {
    return personasCollection.add(persona.toMap());
  }

  Future<List<Persona>> getPersonas() async {
    QuerySnapshot querySnapshot = await personasCollection.get();
    return querySnapshot.docs
        .map((doc) =>
            Persona.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updatePersona(Persona persona) {
    return personasCollection.doc(persona.id).update(persona.toMap());
  }

  Future<void> deletePersona(String personaId) {
    return personasCollection.doc(personaId).delete();
  }
}
