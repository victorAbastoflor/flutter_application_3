import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/LoginUp/buttonAnimate.dart';
import 'package:flutter_application_3/View/model/Persona_model.dart';
import 'package:flutter_application_3/View/registro/registerClient_view.dart';
import 'package:flutter_application_3/View/registro/registerOwner.dart';
import 'package:flutter_application_3/View/screen/screen_view.dart';
import 'package:flutter_application_3/View/validations/dialog_view.dart';
import 'package:flutter_application_3/View/validations/validation_clas.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  int _toggleValue = 0;
  TextEditingController _textController1 = TextEditingController();
  TextEditingController _textController2 = TextEditingController();
  bool _showPassword = false;
  bool _showLoginForm = true;
  String _selectedRole = 'Cliente';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap logic here
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/fondInicio.png'), // Ruta de la imagen de fondo
                  fit:
                      BoxFit.cover, // Puedes ajustar esto según tus necesidades
                ),
                border: Border.all(
                  color: Color(0x004B39EF),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenInit(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .transparent, // Establece el color de fondo a transparente
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Icon(
                          Icons.west,
                          color: Color.fromARGB(255, 235, 181, 181),
                          size: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_showLoginForm)
                                Column(
                                  children: [
                                    Text(
                                      'INICIO DE ',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Exa',
                                        color: Colors.white,
                                        fontSize: 35,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'SESIÓN',
                                          style: TextStyle(
                                            fontFamily: 'Lexend Exa',
                                            color: Colors.white,
                                            fontSize: 35,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Icon(
                                            Icons.key_sharp,
                                            color: Color(0xFFFFB42E),
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    Text(
                                      'REGISTRO DE ',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Exa',
                                        color: Colors.white,
                                        fontSize: 35,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'USUARIO',
                                          style: TextStyle(
                                            fontFamily: 'Lexend Exa',
                                            color: Colors.white,
                                            fontSize: 35,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Icon(
                                            Icons.app_registration,
                                            color: Color(0xFFFFB42E),
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _showLoginForm ? 450 : 500,
                        decoration: BoxDecoration(
                          color: Color(0xC2000000),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedToggle(
                                    values: ['Conectarse', 'Regístrate'],
                                    onToggleCallback: (value) {
                                      setState(() {
                                        _toggleValue = value;
                                        _showLoginForm = value == 0;
                                      });
                                    },
                                    buttonColor: const Color(0xFF9A0327),
                                    backgroundColor: const Color(0xFF545051),
                                    textColor: const Color(0xFFFFFFFF),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(60, 60, 60, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_showLoginForm)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'USUARIO',
                                          style: TextStyle(
                                            fontFamily: 'Aldrich',
                                            color: Color(0xFFFDFDFD),
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _textController1,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            // validator: _model.textController1Validator.asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 45, 0, 0),
                                          child: Text(
                                            'CONTRASEÑA',
                                            style: TextStyle(
                                              fontFamily: 'Aldrich',
                                              color: Color(0xFFFDFDFD),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _textController2,
                                            obscureText: !_showPassword,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _showPassword =
                                                        !_showPassword; // Cambiar el estado de visibilidad
                                                  });
                                                },
                                                icon: Icon(
                                                  _showPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors
                                                      .grey, // Cambiar color del ícono según el estado
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            //validator: _model.textController2Validator.asValidator(context),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'USUARIO',
                                          style: TextStyle(
                                            fontFamily: 'Aldrich',
                                            color: Color(0xFFFDFDFD),
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _textController1,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            // validator: _model.textController1Validator.asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 25, 0, 0),
                                          child: Text(
                                            'CONTRASEÑA',
                                            style: TextStyle(
                                              fontFamily: 'Aldrich',
                                              color: Color(0xFFFDFDFD),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 20),
                                          child: TextFormField(
                                            controller: _textController2,
                                            obscureText: !_showPassword,

                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _showPassword =
                                                        !_showPassword; // Cambiar el estado de visibilidad
                                                  });
                                                },
                                                icon: Icon(
                                                  _showPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors
                                                      .grey, // Cambiar color del ícono según el estado
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            // validator: _model.textController2Validator.asValidator(context),
                                          ),
                                        ),
                                        Text(
                                          'Elige tu rol',
                                          style: TextStyle(
                                            fontFamily: 'Aldrich',
                                            color: Color(0xFFFDFDFD),
                                            fontSize: 20,
                                          ),
                                        ),
                                        DropdownButton<String>(
                                          dropdownColor: Color.alphaBlend(
                                              const Color.fromARGB(
                                                  255, 19, 18, 18),
                                              Colors.black),
                                          value: _selectedRole,
                                          items: <String>[
                                            'Cliente',
                                            'Dueño de Parqueo'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedRole = newValue!;
                                            });
                                          },
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.blue),
                                          underline: Container(
                                            // Cambia el color de la línea inferior del botón
                                            height: 2,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_showLoginForm)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 45, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (ValidationHelper
                                                .areFieldsFilled(
                                                    _textController1.text,
                                                    _textController2.text,
                                                    _selectedRole)) {
                                              if (_selectedRole == "Cliente") {
                                                Persona persona = Persona(
                                                  apellidoMaterno: '',
                                                  apellidoPaterno: '',
                                                  carnetIdentidad: '',
                                                  contrasenia:
                                                      _textController2.text,
                                                  correoElectronico: '',
                                                  genero: '',
                                                  usuario:
                                                      _textController1.text,
                                                  nit: '',
                                                  nombre: '',
                                                  tipoRol: _selectedRole,
                                                );
                                                print(persona);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterClientWidget(
                                                            persona: persona),
                                                  ),
                                                );
                                              } else if (_selectedRole ==
                                                  "Dueño de Parqueo") {
                                                Persona persona = Persona(
                                                  apellidoMaterno: '',
                                                  apellidoPaterno: '',
                                                  carnetIdentidad: '',
                                                  contrasenia:
                                                      _textController2.text,
                                                  correoElectronico: '',
                                                  genero: '',
                                                  usuario:
                                                      _textController1.text,
                                                  nit: '',
                                                  nombre: '',
                                                  tipoRol: _selectedRole,
                                                );
                                                print(persona);

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterOwnerWidget(
                                                            persona: persona),
                                                  ),
                                                );
                                              }
                                            } else {
                                              // Mostrar mensaje de error personalizado si no todos los campos están llenos
                                              DialogHelper.showErrorMessage(
                                                context,
                                                "Error de Validación",
                                                "Por favor, completa todos los campos.",
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF9A0327),
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Container(
                                            width: 270,
                                            height: 60,
                                            child: Center(
                                              child: Text(
                                                'INICIAR SESIÓN',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 45, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Validar si todos los campos están llenos
                                            if (ValidationHelper
                                                .areFieldsFilled(
                                                    _textController1.text,
                                                    _textController2.text,
                                                    _selectedRole)) {
                                              if (_selectedRole == "Cliente") {
                                                Persona persona = Persona(
                                                  apellidoMaterno: '',
                                                  apellidoPaterno: '',
                                                  carnetIdentidad: '',
                                                  contrasenia:
                                                      _textController2.text,
                                                  correoElectronico: '',
                                                  genero: '',
                                                  usuario:
                                                      _textController1.text,
                                                  nit: '',
                                                  nombre: '',
                                                  tipoRol: _selectedRole,
                                                );
                                                print(
                                                    'Esssto es nombre de usuraio: ${persona.usuario}');
                                                print(
                                                    'esto es la contrasenia: ${persona.contrasenia}');

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterClientWidget(
                                                            persona: persona),
                                                  ),
                                                );
                                              } else if (_selectedRole ==
                                                  "Dueño de Parqueo") {
                                                Persona persona = Persona(
                                                  apellidoMaterno: '',
                                                  apellidoPaterno: '',
                                                  carnetIdentidad: '',
                                                  contrasenia:
                                                      _textController2.text,
                                                  correoElectronico: '',
                                                  genero: '',
                                                  usuario:
                                                      _textController1.text,
                                                  nit: '',
                                                  nombre: '',
                                                  tipoRol: _selectedRole,
                                                );

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterOwnerWidget(
                                                            persona: persona),
                                                  ),
                                                );
                                              }
                                            } else {
                                              // Mostrar mensaje de error personalizado si no todos los campos están llenos
                                              DialogHelper.showErrorMessage(
                                                context,
                                                "Error de Validación",
                                                "Por favor, completa todos los campos.",
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF9A0327),
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Container(
                                            width: 270,
                                            height: 60,
                                            child: Center(
                                              child: Text(
                                                'REGISTRARSE',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_showLoginForm)
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0x004B39EF),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Container(
                                width: 310,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
