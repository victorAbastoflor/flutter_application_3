import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditParkingPage extends StatefulWidget {
  final String parqueoId;
  final Function onUpdate;

  EditParkingPage({required this.parqueoId, required this.onUpdate});

  @override
  _EditParkingPageState createState() => _EditParkingPageState();
}

class _EditParkingPageState extends State<EditParkingPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _availableSpotsController = TextEditingController();
  TextEditingController _openingHoursController = TextEditingController();
  TextEditingController _costoPorHoraController = TextEditingController();
  TextEditingController _espaciosDisponiblesController =
      TextEditingController();

  bool _allowCars = false;
  bool _allowMotorcycles = false;
  bool _allowTrucks = false;
  List<File> _images = [];
  List<String> _existingImageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadParkingData();
  }

  void _loadParkingData() async {
    var parqueoData = await FirebaseFirestore.instance
        .collection('parqueosgp')
        .doc(widget.parqueoId)
        .get();
    var data = parqueoData.data();
    if (data != null) {
      setState(() {
        _nameController.text = data['nombre'];
        _locationController.text = data['ubicacion'];
        _latitudeController.text = data['coords'].latitude.toString();
        _longitudeController.text = data['coords'].longitude.toString();
        _availableSpotsController.text = data['espacios'].toString();
        _openingHoursController.text = data['horario'];
        _allowCars = data['vehiculos']['autos'];
        _allowMotorcycles = data['vehiculos']['motos'];
        _allowTrucks = data['vehiculos']['camiones'];
        _existingImageUrls = List<String>.from(data['imagenes'] ?? []);
        _costoPorHoraController.text = data['horaCosto'].toString();
        _espaciosDisponiblesController.text =
            data['espaciosDisponibles'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Parqueo'),
        backgroundColor: Colors.orange,
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nombre del Parqueo'),
            onSaved: (value) => _nameController.text = value!,
          ),
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Ubicación'),
            onSaved: (value) => _locationController.text = value!,
          ),
          TextFormField(
            controller: _latitudeController,
            decoration: InputDecoration(labelText: 'Latitud'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _latitudeController.text = value!,
          ),
          TextFormField(
            controller: _longitudeController,
            decoration: InputDecoration(labelText: 'Longitud'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _longitudeController.text = value!,
          ),
          TextFormField(
            controller: _availableSpotsController,
            decoration: InputDecoration(labelText: 'Número de Plazas'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _availableSpotsController.text = value!,
          ),
          TextFormField(
            controller: _openingHoursController,
            decoration: InputDecoration(labelText: 'Horario de Funcionamiento'),
            onSaved: (value) => _openingHoursController.text = value!,
          ),
          TextFormField(
            controller: _costoPorHoraController,
            decoration: InputDecoration(labelText: 'Costo por Hora'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _costoPorHoraController.text = value!,
          ),
          TextFormField(
            controller: _espaciosDisponiblesController,
            decoration: InputDecoration(labelText: 'Espacios Disponibles'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _espaciosDisponiblesController.text = value!,
          ),
          _buildVehicleTypes(),
          _buildImagePicker(context),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Guardar Cambios'),
            style: ElevatedButton.styleFrom(primary: Colors.orange),
          ),
        ],
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
    String? initialValue,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onSaved: onSaved,
      initialValue: initialValue,
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
        for (var url in _existingImageUrls)
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.network(
                url + "?nocache=${DateTime.now().millisecondsSinceEpoch}",
                key: UniqueKey(),
              ),
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () => _removeExistingImage(url),
              ),
            ],
          ),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Subir Imagen del Parqueo'),
          style: ElevatedButton.styleFrom(primary: Colors.orange),
        ),
      ],
    );
  }

  void _removeExistingImage(String url) {
    setState(() {
      _existingImageUrls.remove(url);
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      List<String> newImageUrls = await _uploadImagesToFirebase();

      await FirebaseFirestore.instance
          .collection('parqueosgp')
          .doc(widget.parqueoId)
          .update({
        'nombre': _nameController.text,
        'ubicacion': _locationController.text,
        'coords': GeoPoint(double.parse(_latitudeController.text),
            double.parse(_longitudeController.text)),
        'espacios': int.parse(_availableSpotsController.text),
        'horario': _openingHoursController.text,
        'horaCosto': double.parse(_costoPorHoraController.text),
        'espaciosDisponibles': int.parse(_espaciosDisponiblesController.text),
        'vehiculos': {
          'autos': _allowCars,
          'motos': _allowMotorcycles,
          'camiones': _allowTrucks,
        },
        'imagenes': [..._existingImageUrls, ...newImageUrls],
      });

      widget.onUpdate();
      Navigator.pop(context, 'updated');
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
