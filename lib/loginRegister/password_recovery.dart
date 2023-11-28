import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Paint/CustomPaintLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickparking_flutter/Pages/home.dart';
import 'package:quickparking_flutter/owner/owner_home.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

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
              'Recuperar\nContraseña',
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
                    _buildSendEmailButton(),
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

  Widget _buildSendEmailButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: ElevatedButton(
        onPressed: _sendResetEmail,
        child: Text(
          'Enviar Correo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[300],
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
      ),
    );
  }

  void _sendResetEmail() {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Correo de restablecimiento enviado")),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al enviar correo")),
        );
      });
    }
  }
}
