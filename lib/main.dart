import 'package:flutter/material.dart';
//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_3/pages/edit_user_page.dart';
import 'firebase_options.dart';

//pages
import 'pages/add_user_page.dart';
import 'pages/home_page.dart';
//import 'pages/edit_user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const AddUserPage(),
        '/edit': (context) => const EditUserPage(),
      },
    );
  }
}
