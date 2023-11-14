import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/View/LoginUp/ResetPass.dart';
import 'package:flutter_application_3/View/LoginUp/but.dart';
import 'package:flutter_application_3/View/LoginUp/login_view.dart';
import 'package:flutter_application_3/View/Qr/QR_view.dart';
import 'package:flutter_application_3/View/home/home_view.dart';
import 'package:flutter_application_3/View/model/Persona_model.dart';
import 'package:flutter_application_3/View/registro/registerClient_view.dart';
import 'package:flutter_application_3/View/registro/registerOwner.dart';
import 'package:flutter_application_3/View/registro/registerPark_view.dart';
import 'package:flutter_application_3/View/screen/screen_view.dart';
import 'package:flutter_application_3/mapeo_user.dart';
import 'package:flutter/material.dart';
//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_3/mapss.dart';
import 'package:flutter_application_3/owner-all/owner_loginpage.dart';
import 'package:flutter_application_3/owner-all/parking_details/RegisteredParkingPage.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';

void main() async {
  // Asegurarse de que los servicios de Flutter estén inicializados antes de usarlos
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase con las opciones predeterminadas
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBkjwzEPm5ELDuCZD6pq6L2D8dFEHN82-4",
      authDomain: "pri-parqueos-8eaba.firebaseapp.com",
      projectId: "pri-parqueos-8eaba",
      storageBucket: "pri-parqueos-8eaba.appspot.com",
      messagingSenderId: "176310540848",
      appId: "1:176310540848:web:43fc4fb794a60a46412bf5",
      measurementId: "G-R5TYNVXQDG",
    ),
  );

  // Iniciar la aplicación
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Persona persona = Persona(
    apellidoMaterno: '',
    apellidoPaterno: '',
    carnetIdentidad: '',
    contrasenia: '',
    correoElectronico: '',
    genero: '',
    usuario: '',
    nit: '',
    nombre: '',
    tipoRol: '',
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      // Definir la ruta inicial
      initialRoute: '/qraaaaAaoQA',
      // Definir las rutas de la aplicación
      routes: {
        '/': (context) => Home(),
        '/qr': (context) => MapView(),
        '/qra': (context) => MapViewLoad(),
        '/qraa': (context) => ScreenInit(),
        '/qraaa': (context) => LoginWidget(),
        '/qraaaa': (context) => RegisterClientWidget(
              persona: persona,
            ),
        '/qraaaaA': (context) => RegisterOwnerWidget(
              persona: persona,
            ),
        '/qraaaaAa': (context) => RegisterPark(),
        '/qraaaaAao': (context) => ResetPasswordScreen(),
        '/qraaaaAaoQ': (context) => QRScreen(),
        '/qraaaaAaoQA': (context) => MyHomePage(),
      },
    );
  }
}
