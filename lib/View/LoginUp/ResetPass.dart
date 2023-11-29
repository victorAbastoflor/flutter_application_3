import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String passwordErrorText = '';
  RegExp passwordValidator =
      RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$');

  void resetPassword() {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      setState(() {
        passwordErrorText = 'Las contraseñas no coinciden.';
      });
      return;
    }

    if (!passwordValidator.hasMatch(newPassword)) {
      setState(() {
        passwordErrorText =
            'La contraseña debe tener al menos 8 caracteres, incluyendo al menos una letra mayúscula, un carácter especial y un número.';
      });
      return;
    }

    newPasswordController.clear();
    confirmPasswordController.clear();
    setState(() {
      passwordErrorText = '';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondInicio.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Restablecer Contraseña",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Nueva Contraseña",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    if (passwordValidator.hasMatch(value)) {
                      setState(() {
                        passwordErrorText = '';
                      });
                    } else {
                      setState(() {
                        passwordErrorText =
                            'La contraseña debe tener al menos 8 caracteres, incluyendo al menos una letra mayúscula, un carácter especial y un número.';
                      });
                    }
                  },
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirmar Contraseña",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  passwordErrorText,
                  style: TextStyle(color: Colors.red),
                ),
                ElevatedButton(
                  onPressed: resetPassword,
                  child: Text(
                    "Restablecer Contraseña",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
