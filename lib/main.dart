import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickparking_flutter/owner/owner_home.dart';
import 'package:quickparking_flutter/loginRegister/homeLogin.dart';
import 'package:quickparking_flutter/Widget/recents.dart';
import 'package:provider/provider.dart';
import 'package:quickparking_flutter/owner/cronometer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase con las opciones predeterminadas
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCGU11y7075njcrsp7UAYI-HvmV_0C3Tig",
        authDomain: "flutterparking-10886.firebaseapp.com",
        projectId: "flutterparking-10886",
        storageBucket: "flutterparking-10886.appspot.com",
        messagingSenderId: "921977256566",
        appId: "1:921977256566:web:23a8d5122d2bbd8a5b3d57",
        measurementId: "G-PNQC0M0X1P"),
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => CronometroModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
//Salaco