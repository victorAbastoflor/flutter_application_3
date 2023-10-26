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

//funcion leer parqueos
/*Future<List> getParqueo() async {
  List parqueo = [];
  CollectionReference parqueosRef = db.collection('Parqueo');
  QuerySnapshot parqueosSnapshot = await parqueosRef.get();
  parqueosSnapshot.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final parqueos = {
      "nombre": data['a_nombreparqueo'],
      "latitud": data['latitud'],
      "c_tipovehiculo": data['c_tipovehiculo'],
      "d_horarioapertura": data['d_horarioapertura'],
      "longitud": data['longitud'],
      "uid": documento.id,
    };
    parqueo.add(parqueos);
  });
  return parqueo;
}*/

Future<List<Map<String, dynamic>>> getParqueos() async {
  List<Map<String, dynamic>> parqueos = [];

  try {
    QuerySnapshot queryParqueos =
        await FirebaseFirestore.instance.collection('parqueos').get();

    queryParqueos.docs.forEach((documento) {
      final Map<String, dynamic> data =
          documento.data() as Map<String, dynamic>;
      final parqueo = {
        "latitud": data['latitud'],
        "longitud": data['longitud'],
        "nombre": data['nombre'],
        "numPlazas": data['numplazas'],
        "direccion": data['direccion'],
        "TipoVehiculo": data['tipoVehiculo'],
        "horaApertura": data['Hora.Apertura'],
        // Puedes agregar otros datos relevantes
        "uid": documento.id,
      };
      parqueos.add(parqueo);
    });
  } catch (error) {
    print("Error al obtener parqueos: $error");
  }

  return parqueos;
}
