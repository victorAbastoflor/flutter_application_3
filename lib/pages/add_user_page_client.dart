import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/firebase_service.dart';

class AddUserPageclient extends StatefulWidget {
  const AddUserPageclient({super.key});
  @override
  State<AddUserPageclient> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPageclient> {
  //controlador para guardar
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            // Usar un widget Form para gestionar la validación
            key: _formKey, // Asignar el GlobalKey al form
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
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese Nombre',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce el nombre';
                    }
                    return null;
                  },
                ),
                const Text(
                  'Apellido Paterno:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: lastController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese apellido paterno',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introdusca su apellido paterno';
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: idController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese carnet identidad',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su número de carnet de identidad';
                    }
                    if (value.length < 7) {
                      return 'El carnet de identidad debe tener al menos 7 caracteres';
                    }
                    return null; // La validación pasó
                  },
                ),
                const Text(
                  'Correo Electronico:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese correo electronico',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su correo electrónico';
                    }
                    final emailRegex = RegExp(
                        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Ingrese un correo electrónico válido';
                    }
                    return null;
                  },
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
                    if (_formKey.currentState?.validate() ?? false) {
                      // Validar el formulario
                      await addPeople(
                        nameController.text,
                        lastController.text,
                        motherLastNameController.text,
                        idController.text,
                        emailController.text,
                        generoSeleccionado,
                      ).then((value) {
                        print("Persona Agregada");
                        Navigator.pushNamed(context, '/login');
                      }).catchError((error) {
                        print("Error al agregar la persona: $error");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error al agregar la persona')),
                        );
                      });
                    }
                  },
                  child: const Text('Guardar'),
                )
              ],
            ),
          )),
    );
  }
}
