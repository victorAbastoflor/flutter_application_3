import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Paint/CustomPaintSignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickparking_flutter/loginRegister/login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String _role = 'Cliente'; // Valor por defecto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TopBar_signup(),
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
            top: 210,
            left: 44,
            child: Text(
              '¡Crear\nCuenta!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 400),
                    _buildNameField(),
                    _buildEmailField(),
                    _buildPasswordField(),
                    _buildPhoneField(),
                    _buildRoleDropdown(),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _register,
                      child: Text(
                        'Registrarse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 18.0),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Correo',
        ),
        validator: (value) => value!.isEmpty ? 'Ingrese su correo' : null,
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
          labelText: 'Nombre Completo',
          // Resto de la decoración...
        ),
        validator: (value) => value!.isEmpty ? 'Ingrese su nombre' : null,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Contraseña',
        ),
        validator: (value) => value!.isEmpty ? 'Ingrese su contraseña' : null,
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
      child: TextFormField(
        controller: _phoneController,
        decoration: InputDecoration(
          labelText: 'Número de Teléfono',
        ),
        validator: (value) =>
            value!.isEmpty ? 'Ingrese su número de teléfono' : null,
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButton<String>(
      value: _role,
      onChanged: (String? newValue) {
        setState(() {
          _role = newValue!;
        });
      },
      items: <String>['Cliente', 'Dueño']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        print("Usuario creado con UID: ${userCredential.user!.uid}");

        String userId = userCredential.user!.uid;

        await FirebaseFirestore.instance
            .collection('usuariosgp')
            .doc(userCredential.user!.uid)
            .set({
          'nombre': _nameController.text,
          'telefono': _phoneController.text,
          'rol': _role,
          'id': userId,
        });
        print("Datos adicionales guardados en Firestore");
      } on FirebaseAuthException catch (e) {
      } catch (e) {}
    }
  }
}
