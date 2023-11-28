import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Paint/CustomPaintLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickparking_flutter/Pages/home.dart';
import 'package:quickparking_flutter/owner/owner_home.dart';
import 'package:quickparking_flutter/loginRegister/password_recovery.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TopBar_login(),
          Positioned(
            top: 40,
            left: 4,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          Positioned(
            top: 180,
            left: 44,
            child: Text(
              'Iniciar\n   Sesión',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 320),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildEmailField(),
                    _buildPasswordField(),
                    _buildLoginButton(),
                    _buildForgotPasswordLink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Correo',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su correo';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 16),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su contraseña';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: ElevatedButton(
        onPressed: _login,
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[900],
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
          );
        },
        child: Text(
          'Olvidé mi contraseña',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  void _redirectBasedOnRole(String userId) async {
    var userDoc = await FirebaseFirestore.instance
        .collection('usuariosgp')
        .doc(userId)
        .get();
    var userRole = userDoc.data()?['rol'];

    if (userRole == 'Cliente') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else if (userRole == 'Dueño') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OwnerHomePage()),
      );
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        print("Inicio de sesión exitoso: ${userCredential.user!.uid}");
        _redirectBasedOnRole(userCredential.user!.uid);
      } on FirebaseAuthException catch (e) {
        print("Error al iniciar sesión: ${e.message}");
      }
    }
  }
}
