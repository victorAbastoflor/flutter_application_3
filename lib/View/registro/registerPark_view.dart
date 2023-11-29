import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/model/LoggedInUser.dart';
import 'package:flutter_application_3/View/model/Parqueos.dart';
import 'package:flutter_application_3/services/FirebaseService.dart';
import 'package:flutter_application_3/services/firebase_service.dart';

class RegisterPark extends StatefulWidget {
  final LoggedInUser currentUser;

  const RegisterPark({Key? key, required this.currentUser}) : super(key: key);

  @override
  _RegisterParkWidgetState createState() => _RegisterParkWidgetState();
}

class _RegisterParkWidgetState extends State<RegisterPark> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;

  void _registerPark() {
    if (widget.currentUser.tipoRol == 'Dueño') {
      if (_areTextFieldsFilled()) {
        // Crear una instancia de Parqueo con la información ingresada
        Parqueo newPark = Parqueo(
          usuario: widget.currentUser.nombre,
          direccion: textController2.text,
          horaApertura: textController4.text,
          nombre: textController1.text,
          numPlazas: int.parse(textController3.text),
          tipoVehiculo: _getSelectedVehicles(),
        );

        // Lógica para registrar el parqueo en Firebase
        FirebaseService().registerPark(newPark);

        // Mostrar mensaje de éxito
        _showSuccessDialog();
      } else {
        print('Por favor, complete todos los campos');
      }
    } else {
      _showPermissionDialog();
    }
  }

  List<String> _getSelectedVehicles() {
    List<String> selectedVehicles = [];
    if (checkboxValue1) selectedVehicles.add('Vehículo');
    if (checkboxValue2) selectedVehicles.add('Moto');
    return selectedVehicles;
  }

  bool _areTextFieldsFilled() {
    return textController1.text.isNotEmpty &&
        textController2.text.isNotEmpty &&
        textController3.text.isNotEmpty &&
        textController4.text.isNotEmpty;
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registro Exitoso'),
        content: Text('¡El parqueo se registró con éxito!'),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Acceso Restringido'),
        content: Text('Solo los dueños pueden registrar parqueos.'),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  iconSize: 24,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0x84000000),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTRO DEL PARQUEO',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 20),
                        buildTextFormField(
                            textController1, 'NOMBRE DEL PARQUEO:'),
                        buildTextFormField(
                            textController2, 'DIRECCIÓN DEL PARQUEO:'),
                        buildTextFormField(
                            textController3, 'NÚMERO DE PLAZAS:'),
                        buildTextFormField(
                            textController4, 'HORARIO FUNCIONAMIENTO:'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildCheckbox('Vehículo', checkboxValue1,
                                (value) {
                              setState(() => checkboxValue1 = value!);
                            }),
                            buildCheckbox(
                                'Moto', checkboxValue2, (value) {
                              setState(() => checkboxValue2 = value!);
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ElevatedButton(
                    onPressed: _registerPark,
                    child: Text('Registrar Parqueo'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF9A0327),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      TextEditingController controller, String hintText) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        autofocus: true,
        obscureText: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Readex Pro',
            color: Colors.white,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        style: TextStyle(
          fontFamily: 'Readex Pro',
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget buildCheckbox(
      String title, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Readex Pro',
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          checkColor: Colors.black,
        ),
      ],
    );
  }
}
