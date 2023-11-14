import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/mapss.dart';

class MenuHomeWidget extends StatefulWidget {
  const MenuHomeWidget({Key? key}) : super(key: key);

  @override
  _MenuHomeWidgetState createState() => _MenuHomeWidgetState();
}

class _MenuHomeWidgetState extends State<MenuHomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Variable para controlar el widget a mostrar en el contenedor
  Widget _currentWidget = Container(); // Widget inicial vacío

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xC6272727),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo
            Image.asset(
              'assets/fondMenu.png', // Ruta de tu imagen de fondo
              fit: BoxFit.cover, // Ajustar la imagen al tamaño del contenedor
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                        child: Icon(
                          Icons.west,
                          color: Color(0xFFFDFDFD),
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.77,
                      decoration: BoxDecoration(
                        color: Color(0x6B000000),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      //mostrar el widget seleccionado
                      child: _currentWidget,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0x64000000),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildMenuColumn(Icons.map, 'Mapas'),
                            _buildMenuColumn(
                                Icons.data_thresholding_outlined, 'Reporte'),
                            _buildMenuColumn(
                                Icons.add_home_outlined, 'Agregar'),
                            _buildMenuColumn(Icons.favorite_border, 'Favorito'),
                            _buildMenuColumn(Icons.login, 'Cerrar sesion'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Método para mostrar el widget MapViewLoad en el contenedor al hacer clic en el icono de mapas
  void _showMapViewLoadWidget() {
    setState(() {
      _currentWidget =
          MapViewLoad(); // Reemplaza MapViewLoad() con tu widget correspondiente
    });
  }

  Widget _buildMenuColumn(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (label == 'Mapas') {
              _showMapViewLoadWidget(); // Mostrar MapViewLoad al hacer clic en Mapas
            }
            // Agregar lógica para otros íconos aquí si es necesario
          },
          child: Icon(
            icon,
            color: Color(0xFFFDFDFD),
            size: 40,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Readex Pro',
            color: Color(0xFFFDFDFD),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
