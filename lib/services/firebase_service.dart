import 'package:cloud_firestore/cloud_firestore.dart';

//instancia del firestore
FirebaseFirestore db = FirebaseFirestore.instance;
//funcion leer
Future<List> getPersona() async {
  List person = [];
  CollectionReference collectionReferencePersona = db.collection('Persona');
  QuerySnapshot queryPersona = await collectionReferencePersona.get();
  queryPersona.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final persona = {
      "nombre": data['nombre'],
      "ApellidoPaterno": data['ApellidoPaterno'],
      "ApellidoMaterno": data['ApellidoMaterno'],
      "CarnetIdentidad": data['CarnetIdentidad'],
      "CorreoElectronico": data['CorreoElectronico'],
      "Genero": data['Genero'],
      "uid": documento.id,
    };
    person.add(persona);
  });
  return person;
}

// Guardar un user y contraseña en base de datos
Future<void> addUser(String username, String password, String role) async {
  await db.collection("Usuario").add({
    "Usuario": username,
    "Contrasenia": password,
    "tipoRol": role,
  });
}

// Guardar un user en base de datos
Future<void> addPeople(String name, String lastname, String last2name,
    String nit, String correo, String genero) async {
  await db.collection("Persona").add({
    "nombre": name,
    "ApellidoPaterno": lastname,
    "ApellidoMaterno": last2name,
    "CarnetIdentidad": nit,
    "CorreoElectronico": correo,
    "Genero": genero,
  });
}

// Actualizar un user en base de datos
Future<void> updatePeople(String uid, String name, String lastname,
    String last2name, String nit, String correo, String genero) async {
  try {
    await db.collection("Persona").doc(uid).update({
      "nombre": name,
      "ApellidoPaterno": lastname,
      "ApellidoMaterno": last2name,
      "CarnetIdentidad": nit,
      "CorreoElectronico": correo,
      "Genero": genero,
    });
    print("Usuario actualizado correctamente.");
  } catch (error) {
    print("Error al actualizar el usuario: $error");
  }
}

// Borrar datos de Firebase
Future<void> deletePeople(String uid) async {
  await db.collection("Persona").doc(uid).delete();
}
