import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/home/home_view.dart';
import 'package:flutter_application_3/View/model/LoggedInUser.dart';
import 'package:flutter_application_3/View/model/Rol.dart';
import 'package:flutter_application_3/View/model/User.dart';
import 'package:flutter_application_3/View/registro/registerClient_view.dart';
import 'package:flutter_application_3/View/registro/registerOwner.dart';
import 'package:flutter_application_3/View/validations/dialog_view.dart';
import 'package:flutter_application_3/View/validations/validation_clas.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _textController1 = TextEditingController(); 
  final _textController2 = TextEditingController(); 
  final _textController3 = TextEditingController(); 
  bool _showPassword = false;
  bool _showLoginForm = true;
  String? _selectedRole;
  List<Rol> _rolesList = [];
  LoggedInUser? loggedInUser;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    super.dispose();
  }

  Future<void> _fetchRoles() async {
    final rolesCollection = FirebaseFirestore.instance.collection('Rol');
    try {
      final querySnapshot = await rolesCollection.get();
      final roles = querySnapshot.docs.map((doc) {
        print('Doc data: ${doc.data()}');
        String id = doc.id; 
        String nameRole = doc.data()?['NameRole'] ?? '';
        return Rol(id: id, nameRole: nameRole);
      }).toList();

      if (roles.isNotEmpty) {
        print('Roles fetched: ${roles.map((r) => r.nameRole).join(', ')}'); 
        setState(() {
          _rolesList = roles;
          _selectedRole = roles.isNotEmpty ? roles.first.nameRole : null;
        });
      } else {
        print('No roles found in the database.');
      }
    } catch (e) {
      print('Error fetching roles: $e'); 
    }
  }

  Future<void> _registerUser() async {
  if (_selectedRole != null) {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('Usuario').add({
        'Usuario': _textController1.text,
        'Contrasenia': _textController2.text,
        'Nombre': _textController3.text,
        'TipoRol': _selectedRole,
      });

      print("Usuario registrado con éxito");
      
    } catch (e) {
      print("Error al registrar usuario: $e");
    }
  } else {
    print("Por favor seleccione un rol");
  }
}

  Future<void> _loginUser() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Usuario')
          .where('Usuario', isEqualTo: _textController1.text.trim()) // Asegúrate de usar trim() para eliminar espacios en blanco
          .where('Contrasenia', isEqualTo: _textController2.text.trim()) // Igual aquí
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;
        print('UserDoc: $userDoc');
        // Asegúrate de que los campos existen y no son nulos antes de continuar
        String username = userDoc['Usuario'] ?? '';
        String name = userDoc['Nombre'] ?? '';
        String role = userDoc['TipoRol'] ?? '';

        // Ahora comprobamos que ninguno de los campos es vacío
        if (username.isNotEmpty && name.isNotEmpty && role.isNotEmpty) {
          loggedInUser = LoggedInUser(
            usuario: username,
            nombre: name,
            tipoRol: role,
            contrasenia: _textController2.text.trim(), // Aquí usamos el valor ingresado directamente
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MenuHomeWidget(
              loggedInUser: loggedInUser!,
            ),
          ));
        } else {
          // Si algún campo está vacío, mostramos un error
          _showErrorSnackBar('Alguno de los datos es incorrecto o está vacío.');
        }
      } else {
        _showErrorSnackBar('Usuario o contraseña incorrectos');
      }
    } catch (e) {
      _showErrorSnackBar('Error al iniciar sesión: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }



  
  Widget _buildHeader() {
    return Text(
      _showLoginForm ? 'INICIO DE SESIÓN' : 'REGISTRO DE USUARIO',
      style: TextStyle(
        fontFamily: 'Lexend Exa',
        color: Colors.white,
        fontSize: 35,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !_showPassword : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => _showPassword = !_showPassword);
                  },
                )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Encabezado
                  _buildHeader(),
                  // Campos de texto para Usuario y Contraseña
                  _buildTextField(
                    controller: _textController1,
                    label: 'Usuario',
                  ),
                  _buildTextField(
                    controller: _textController2,
                    label: 'Contraseña',
                    isPassword: true,
                  ),
                  // Campo de texto para Nombre/Nickname - Se muestra solo en modo de registro
                  if (!_showLoginForm)
                    _buildTextField(
                      controller: _textController3,
                      label: 'Nombre/Nickname',
                    ),
                  // Dropdown de Roles - Se muestra solo en modo de registro
                  if (!_showLoginForm)
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: _buildRoleDropdown(),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_showLoginForm) {
                          // Si estamos en la pantalla de inicio de sesión, intentamos iniciar sesión.
                          _loginUser();
                          print('Usuario logueado: $loggedInUser');
                        } else {
                          // Si estamos en la pantalla de registro, intentamos registrar un nuevo usuario.
                          _registerUser();
                          print('Rol seleccionado para registro: $_selectedRole');
                        }
                      },
                      child: Text(
                        _showLoginForm ? 'INICIAR SESIÓN' : 'REGISTRARSE',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showLoginForm = !_showLoginForm;
                        _textController1.clear();
                        _textController2.clear();
                        _textController3.clear();
                      });
                    },
                    child: Text(
                      _showLoginForm ? '¿No tienes una cuenta? Regístrate' : '¿Ya tienes una cuenta? Inicia sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



   Widget _buildRoleDropdown() {
    // Asegúrate de que este método se llama dentro de tu método build cuando esté en modo de registro
    return DropdownButton<String>(
      value: _selectedRole,
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue;
        });
      },
      items: _rolesList.map<DropdownMenuItem<String>>((Rol role) {
        return DropdownMenuItem<String>(
          value: role.nameRole,
          child: Text(role.nameRole),
        );
      }).toList(),
      isExpanded: true,
      hint: Text('Seleccione un rol'),
      dropdownColor: Colors.black,
      style: TextStyle(color: Colors.white),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
    );
  }
}


