import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/View/LoginUp/login_view.dart';
import 'package:flutter_application_3/View/home/favorites_view.dart';
import 'package:flutter_application_3/View/model/LoggedInUser.dart';
import 'package:flutter_application_3/View/registro/registerPark_view.dart';
import 'package:flutter_application_3/View/screen/screen_view.dart';
import 'package:flutter_application_3/mapss.dart';
import 'package:flutter_application_3/pages/profile.dart';

class MenuHomeWidget extends StatefulWidget {
  final LoggedInUser? loggedInUser;
  const MenuHomeWidget({Key? key, this.loggedInUser}) : super(key: key);

  @override
  _MenuHomeWidgetState createState() => _MenuHomeWidgetState();
}

class _MenuHomeWidgetState extends State<MenuHomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _currentWidget = Container(); // Widget inicial vacío

  void _showProfile() {
    if (widget.loggedInUser != null) {
      setState(() {
        _currentWidget = ProfileWidget(user: widget.loggedInUser!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xC6272727),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fondMenu.png', // Ajusta la ruta de tu imagen de fondo
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.77,
                    decoration: BoxDecoration(
                      color: Color(0x6B000000),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: _currentWidget,
                  ),
                ),
                _buildMenuButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMapViewLoadWidget(String label) {
    switch (label) {
      case 'Mapas':
        setState(() {
          _currentWidget = MapViewLoad(loggedInUser: widget.loggedInUser!);
        });
        break;
      case 'Cerrar sesion':
        setState(() {
          _currentWidget = ScreenInit();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginWidget(),
          ));
        });
        break;
      case 'Perfil':
        _showProfile();
        break;
      case 'Clientes':
        if (widget.loggedInUser != null && widget.loggedInUser!.tipoRol == 'Dueño') {
          setState(() {
            _currentWidget = FavoritesScreen(loggedInUser: widget.loggedInUser);
          });
        } else {
          _showErrorDialog('Acceso Restringido: Solo los dueños pueden ver clientes.');
        }
        break;
      case 'Agregar':
        if (widget.loggedInUser != null && widget.loggedInUser!.tipoRol == 'Dueño') {
          setState(() {
            _currentWidget = RegisterPark(currentUser: widget.loggedInUser!);
          });
        } else {
          _showErrorDialog('Solo los dueños pueden agregar parqueos.');
        }
        break;
    }
  }


  Widget _buildMenuButtons() {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Wrap( 
          alignment: WrapAlignment.spaceEvenly,
          children: [
            _buildMenuButton(Icons.park_rounded, 'Parqueo', () => _showMapViewLoadWidget('Mapas')),
            _buildMenuButton(Icons.people, 'Clientes',  () => _showMapViewLoadWidget('Clientes')),
            _buildMenuButton(Icons.add, 'Registrar', () => _showMapViewLoadWidget('Agregar')),
            _buildMenuButton(Icons.person_2, 'Perfil', _showProfile),
            _buildMenuButton(Icons.login, 'Cerrar sesión', () => _showMapViewLoadWidget('Cerrar sesion')),
          ],
        ),
      ),
    );
  }


  Widget _buildMenuButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
            horizontal: 8, vertical: 8), // Padding reducido
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: Color(0xFFFDFDFD), size: 30), // Tamaño de icono reducido
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFFDFDFD),
              fontSize: 12, // Tamaño de fuente reducido
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Acceso Restringido'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  
}
