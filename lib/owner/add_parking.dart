import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickparking_flutter/Pages/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddParkingPage extends StatefulWidget {
  @override
  _AddParkingPageState createState() => _AddParkingPageState();
}

class _AddParkingPageState extends State<AddParkingPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  GeoPoint _locationCoords = GeoPoint(0.0, 0.0);
  int _availableSpots = 0;
  String _openingHours = '';
  bool _allowCars = false;
  bool _allowMotorcycles = false;
  bool _allowTrucks = false;
  List<File> _images = []; //multiples images
  double _costoPorHora = 0.0;
  int _espaciosDisponibles = 0;
  String ownerId = FirebaseAuth.instance.currentUser!.uid;
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Parqueo'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/fondo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              _buildTextField(
                label: 'Nombre del Parqueo',
                onSaved: (value) => _name = value!,
              ),
              _buildTextField(
                label: 'Ubicación',
                onSaved: (value) => _location = value!,
              ),
              _buildTextField(
                label: 'Latitud',
                onSaved: (value) {
                  double lat = double.tryParse(value!) ?? 0.0;
                  _locationCoords = GeoPoint(lat, _locationCoords.longitude);
                },
              ),
              _buildTextField(
                label: 'Longitud',
                onSaved: (value) {
                  double lon = double.tryParse(value!) ?? 0.0;
                  _locationCoords = GeoPoint(_locationCoords.latitude, lon);
                },
              ),
              _buildTextField(
                label: 'Número de Plazas',
                onSaved: (value) => _availableSpots = int.tryParse(value!) ?? 0,
              ),
              _buildTextField(
                label: 'Horario de Funcionamiento',
                onSaved: (value) => _openingHours = value!,
              ),
              _buildTextField(
                label: 'Costo por Hora',
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _costoPorHora = double.tryParse(value!) ?? 0.0,
              ),
              _buildTextField(
                label: 'Espacios Disponibles',
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _espaciosDisponibles = int.tryParse(value!) ?? 0,
              ),
              _buildVehicleTypes(),
              _buildImagePicker(context),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Guardar Parqueo'),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleTypes() {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text("Autos"),
          value: _allowCars,
          onChanged: (bool? value) {
            setState(() {
              _allowCars = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text("Motos"),
          value: _allowMotorcycles,
          onChanged: (bool? value) {
            setState(() {
              _allowMotorcycles = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text("Camiones"),
          value: _allowTrucks,
          onChanged: (bool? value) {
            setState(() {
              _allowTrucks = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String?) onSaved,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _images.map((image) {
              return Container(
                margin: EdgeInsets.all(8),
                child: Image.file(image, width: 100, height: 100),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Subir Imagen del Parqueo'),
          style: ElevatedButton.styleFrom(primary: Colors.orange),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('Usuario no autenticado');
        return;
      }
      try {
        List<String> imageUrls = await _uploadImagesToFirebase();

        String ownerId = FirebaseAuth.instance.currentUser!.uid;
        print('UID del usuario actual: $ownerId');

        var parqueo = {
          'nombre': _name,
          'ubicacion': _location,
          'coords':
              GeoPoint(_locationCoords.latitude, _locationCoords.longitude),
          'imagenes': imageUrls,
          'espacios': _availableSpots,
          'horario': _openingHours,
          'espaciosDisponibles': _espaciosDisponibles,
          'horaCosto': _costoPorHora,
          'vehiculos': {
            'autos': _allowCars,
            'motos': _allowMotorcycles,
            'camiones': _allowTrucks,
          },
          'ownerId': ownerId,
        };

        var documentRef = await FirebaseFirestore.instance
            .collection('parqueosgp')
            .add(parqueo);
        print("Parqueo guardado con ID: ${documentRef.id}");

        await FirebaseFirestore.instance
            .collection('parqueosgp')
            .doc(documentRef.id)
            .update({'parqueoId': documentRef.id});

        LatLng newMarkerCoords =
            LatLng(_locationCoords.latitude, _locationCoords.longitude);

        if (_locationCoords.latitude != 0.0 &&
            _locationCoords.longitude != 0.0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapView(
                newMarkerCoords: LatLng(
                  _locationCoords.latitude,
                  _locationCoords.longitude,
                ),
                newMarkerId: documentRef.id,
              ),
            ),
          );
        }
      } catch (e) {
        print('Error al guardar el parqueo duke: $e');
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  Future<List<String>> _uploadImagesToFirebase() async {
    List<String> imageUrls = [];
    for (var image in _images) {
      String imageUrl = await _uploadImageToFirebase(image);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  Future<String> _uploadImageToFirebase(File image) async {
    String fileName =
        'parqueos/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
