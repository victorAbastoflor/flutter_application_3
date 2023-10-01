import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/firebase_service.dart';

class AddUserPageclient extends StatefulWidget {
  const AddUserPageclient({super.key});
  @override
  State<AddUserPageclient> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPageclient> {
  //controlador para guardar
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController lastController = TextEditingController(text: "");
  TextEditingController motherLastNameController =
      TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  String generoSeleccionado = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Name'),
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
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese Nombre',
                ),
              ),
              const Text(
                'Apellido Paterno:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: lastController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese apellido paterno',
                ),
              ),
              const Text(
                'Apellido Materno:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: motherLastNameController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese apellido materno',
                ),
              ),
              const Text(
                'Carnet de Identidad:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese carnet identidad',
                ),
              ),
              const Text(
                'Correo Electronico:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese correo electronico',
                ),
              ),
              const Text(
                'Género:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: generoSeleccionado == 'M',
                    onChanged: (bool? newValue) {
                      setState(() {
                        generoSeleccionado = newValue == true ? 'M' : '';
                      });
                    },
                  ),
                  const Text('Masculino'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: generoSeleccionado == 'F',
                    onChanged: (bool? newValue) {
                      setState(() {
                        generoSeleccionado = newValue == true ? 'F' : '';
                      });
                    },
                  ),
                  const Text('Femenino'),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  await addPeople(
                    nameController.text,
                    lastController.text,
                    motherLastNameController.text,
                    idController.text,
                    emailController.text,
                    generoSeleccionado,
                  ).then((_) {
                    Navigator.pushNamed(context, '/login');
                  });
                },
                child: const Text('Guardar'),
              )
            ],
          ),
        ));
  }
}
