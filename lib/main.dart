import 'package:flutter/material.dart';
//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}
