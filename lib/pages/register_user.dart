import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/firebase_service.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  // Controladores para guardar datos
  TextEditingController userName = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: userName,
              decoration: const InputDecoration(
                hintText: 'Ingrese su Usuario',
              ),
            ),
            const Text(
              'Contraseña:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: 'Ingrese Contraseña',
              ),
              obscureText:
                  true, // Esto ocultará la contraseña mientras se escribe
            ),
            const Text(
              'Rol:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedRole,
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
              items: ['Cliente', 'Dueño'].map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Seleccione un Rol'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRole != null) {
                  if (selectedRole == 'Cliente') {
                    await addUser(
                      userName.text,
                      password.text,
                      selectedRole!,
                    ).then((_) {
                      Navigator.pushNamed(context, '/addclient');
                    });
                  } else if (selectedRole == 'Dueño') {
                     await addUser(
                      userName.text,
                      password.text,
                      selectedRole!,
                    ).then((_) {
                      Navigator.pushNamed(context, '/adddueño');
                    });               
                  }              
                } else {
                  // Muestra un mensaje de error si no se ha seleccionado un rol
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, seleccione un rol.'),
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
