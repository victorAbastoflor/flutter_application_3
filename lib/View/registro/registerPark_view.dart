import 'package:flutter/material.dart';

class RegisterPark extends StatefulWidget {
  const RegisterPark({Key? key}) : super(key: key);

  @override
  _RegisterParkWidgetState createState() => _RegisterParkWidgetState();
}

class _RegisterParkWidgetState extends State<RegisterPark> {
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.west,
                        color: Color(0xFFFDFDFD),
                        size: 45,
                      ),
                    ],
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
                                'REGISTRO\nDEL PARQUEO',
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
                                    hintText: 'NOMBRE DEL PARQUEO:',
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
                                    hintText: 'DIRECCIÓN DEL PARQUEO:',
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
                                    hintText: 'NÚMERO DE PLAZAS:',
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
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 35),
                                child: TextFormField(
                                  controller: textController4,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'HORARIO FUNCIONAMIENTO:',
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Vehículo',
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
                                    'Moto',
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
                        child: Text('AGREGAR USUARIO'),
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
