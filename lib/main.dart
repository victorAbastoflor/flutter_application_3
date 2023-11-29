import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/LoginUp/ResetPass.dart';
import 'package:flutter_application_3/View/LoginUp/login_view.dart';
import 'package:flutter_application_3/View/home/favorites_view.dart';
import 'package:flutter_application_3/View/home/home_view.dart';
import 'package:flutter_application_3/View/model/LoggedInUser.dart';
import 'package:flutter_application_3/View/model/User.dart';
import 'package:flutter_application_3/View/registro/registerClient_view.dart';
import 'package:flutter_application_3/View/registro/registerOwner.dart';
import 'package:flutter_application_3/View/registro/registerPark_view.dart';
import 'package:flutter_application_3/View/screen/screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_3/mapss.dart';
import 'package:flutter_application_3/pages/home_page.dart';

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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User persona = User(
    nombre: '',
    tipoRol: '',
    contrasenia: '',
    usuario: '',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/qraaaaAaoQA',
      routes: {
        '/': (context) => Home(),
        '/qra': (context) => FutureBuilder<LoggedInUser>(
          future: getLoggedInUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // handle the error
                return SomeErrorWidget();
              } else {
                return MapViewLoad(loggedInUser: snapshot.data!);
              }
            } else {
              // show a loading spinner
              return CircularProgressIndicator();
            }
          },
        ),
        '/qraa': (context) => ScreenInit(),
        '/qraaa': (context) => LoginWidget(),
        '/qraaaa': (context) => RegisterClientWidget(user: persona),
        '/qraaaaA': (context) => RegisterOwnerWidget(user: persona),
        '/qraaaaAA': (context) => FavoritesScreen(),
        '/qraaaaAa': (context) => FutureBuilder<LoggedInUser>(
          future: getLoggedInUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return RegisterPark(currentUser: snapshot.data ?? LoggedInUser(
                contrasenia: 'defaultPassword',
                usuario: 'defaultUser',
                nombre: 'defaultName',
                tipoRol: 'defaultRole',
              ));
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        '/qraaaaAao': (context) => ResetPasswordScreen(),
        '/qraaaaAaoQA': (context) => FutureBuilder<LoggedInUser>(
          future: getLoggedInUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              LoggedInUser loggedInUser = snapshot.data ?? LoggedInUser(
                contrasenia: 'defaultPassword',
                usuario: 'defaultUser',
                nombre: 'defaultName',
                tipoRol: 'defaultRole',
              );

              return MenuHomeWidget(loggedInUser: loggedInUser);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        '/qraaaaAaoQAq': (context) => ResetPasswordScreen(),
      },
    );
  }

  Future<LoggedInUser> getLoggedInUser() async {
    // Lógica para obtener el usuario autenticado
    // En este ejemplo, se retorna un usuario predeterminado
    return LoggedInUser.fromMap({
      'Contrasenia': 'una_contrasenia_valida',
      'Usuario': 'usuario',
      'Nombre': 'nombre',
      'TipoRol': 'tipoRol',
    });
  }
}

class SomeErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text("Oops! Something went wrong."),
      ),
    );
  }
}
