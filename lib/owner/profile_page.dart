import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot? userData;

  @override
  void initState() {
    super.initState();
    _obtenerDatosUsuario();
  }

  void _obtenerDatosUsuario() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('usuariosgp')
          .doc(user!.uid)
          .get();
      if (snapshot.exists) {
        setState(() {
          userData = snapshot;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  ImageProvider<Object> _obtenerImagenPerfil() {
    var data = userData!.data() as Map<String, dynamic>?;
    if (data != null &&
        data.containsKey('imagenPerfil') &&
        data['imagenPerfil'] != null) {
      return NetworkImage(data['imagenPerfil']);
    } else {
      return AssetImage('image/avatar.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color(0xFFB71C1C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userData == null
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _obtenerImagenPerfil(),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 8,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              userData!['nombre'] ?? 'Nombre no disponible',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB71C1C)),
                            ),
                            Divider(
                                color: Color(0xFFB71C1C),
                                thickness: 1,
                                height: 20),
                            InfoRow('Correo:',
                                user!.email ?? 'Correo no disponible'),
                            InfoRow('Rol:',
                                userData!['rol'] ?? 'Rol no disponible'),
                            InfoRow(
                                'Teléfono:',
                                userData!['telefono'] ??
                                    'Teléfono no disponible'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      label: Text('Cambiar Imagen de Perfil',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () => _cambiarImagenPerfil(),
                      style: ElevatedButton.styleFrom(primary: Colors.black87),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Cerrar Sesión'),
                      onTap: () => _cerrarSesion(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget InfoRow(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _cambiarImagenPerfil() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);

      String filePath = 'imagenes_perfil/${user!.uid}.png';
      try {
        await FirebaseStorage.instance.ref(filePath).putFile(file);
        String downloadURL =
            await FirebaseStorage.instance.ref(filePath).getDownloadURL();

        await FirebaseFirestore.instance
            .collection('usuariosgp')
            .doc(user!.uid)
            .update({
          'imagenPerfil': downloadURL,
        });

        setState(() {
          _obtenerDatosUsuario();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void _cerrarSesion() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
