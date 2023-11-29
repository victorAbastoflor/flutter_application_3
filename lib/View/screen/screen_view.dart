import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/LoginUp/login_view.dart';

class ScreenInit extends StatefulWidget {
  const ScreenInit({Key? key}) : super(key: key);

  @override
  ScreenInitState createState() => ScreenInitState();
}

class ScreenInitState extends State<ScreenInit> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap logic here
      },
      child: Scaffold(
        backgroundColor: Color(0x6B000000),
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/fondInit.png'), // Ruta de la imagen de fondo
                fit: BoxFit.cover, // Puedes ajustar esto según tus necesidades
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 300,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        'PARQUEOS',
                        style: TextStyle(
                          fontFamily: 'Lexend Exa',
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginWidget()));
                          print('Button pressed ...');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF9A0327),
                          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Container(
                          width: 170,
                          height: 50,
                          child: Center(
                            child: Text(
                              'INICIAR SESIÓN',
                              style: TextStyle(
                                fontFamily: 'Krona One',
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿No tienes una cuenta?',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginWidget()));
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              ),
                              child: Text(
                                'Registrate aquí',
                                style: TextStyle(
                                  fontFamily: 'Aldrich',
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
