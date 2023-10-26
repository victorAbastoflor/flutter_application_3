import 'package:flutter/material.dart';
//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_3/pages/add_user_page_client.dart';
import 'package:flutter_application_3/pages/edit_user_page.dart';
import 'package:flutter_application_3/pages/login.dart';
import 'package:flutter_application_3/pages/register_user.dart';
import 'package:flutter_application_3/pages/map_favorite.dart';
import 'package:flutter_application_3/pages/pampruebas.dart';
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
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/menu',
      routes: {
        're': (context) => RegisterUser(),
        //'/': (context) => map_favorite(),
        '/': (context) => MapView(),
        '/menu': (context) => const Home(),
        '/add': (context) => const AddUserPage(),
        '/addclient': (context) => const AddUserPageclient(),
        '/edit': (context) => const EditUserPage(),
        '/login': (context) => HolaMundo(),
      },
    );
  }
}
