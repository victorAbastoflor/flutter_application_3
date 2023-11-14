import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/LoginUp/login_view.dart';
import 'package:flutter_application_3/View/model/Persona_model.dart';

class RegisterClientWidget extends StatefulWidget {
  final Persona persona;
  const RegisterClientWidget({Key? key, required this.persona})
      : super(key: key);

  @override
  _RegisterClientWidgetState createState() => _RegisterClientWidgetState();
}

class _RegisterClientWidgetState extends State<RegisterClientWidget> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/fondRegist.png'), // Ruta de la imagen de fondo
              fit: BoxFit.cover, // Puedes ajustar esto según tus necesidades
            ),
            border: Border.all(
              color: Color(0x004B39EF),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginWidget(),
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
                  padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 550,
                    decoration: BoxDecoration(
                      color: Color(0x84000000),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 10, 0, 50),
                              child: Text(
                                'REGISTRO\nDEL CLIENTE',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: TextFormField(
                                  controller: textController1,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'NOMBRE:',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFDFDFD),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: TextFormField(
                                  controller: textController2,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'APELLIDO PATERNO:',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFDFDFD),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: TextFormField(
                                  controller: textController3,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'APELLIDO MATERNO:',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFDFDFD),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: TextFormField(
                                  controller: textController4,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'CARNET DE IDENTIDAD:',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFDFDFD),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: TextFormField(
                                  controller: textController5,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'CORREO ELECTRÓNICO:',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFDFDFD),
                                      fontSize: 20,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text(
                                  'GÉNERO:',
                                  style: TextStyle(
                                    fontFamily: 'Aldrich',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'M',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFDFDFD),
                                      fontSize: 20,
                                    ),
                                  ),
                                  Checkbox(
                                    value: checkboxValue1,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkboxValue1 = newValue!;
                                      });
                                    },
                                    activeColor: Color(
                                        0xFFFDFDFD), // Color de fondo cuando está seleccionado
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Color(
                                            0xFF000000); // Color de fondo cuando está seleccionado
                                      }
                                      return Colors
                                          .white; // Color de fondo cuando no está seleccionado
                                    }),
                                  ),
                                  Text(
                                    'F',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFDFDFD),
                                      fontSize: 20,
                                    ),
                                  ),
                                  Checkbox(
                                    value: checkboxValue2,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkboxValue2 = newValue!;
                                      });
                                    },
                                    activeColor: Color(
                                        0xFFFDFDFD), // Color de fondo cuando está seleccionado
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Color(
                                            0xFF000000); // Color de fondo cuando está seleccionado
                                      }
                                      return Colors
                                          .white; // Color de fondo cuando no está seleccionado
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        child: Text('REGISTRAR'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF9A0327),
                          onPrimary: Colors.white,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          textStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 25,
                          ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
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
    );
  }
}
