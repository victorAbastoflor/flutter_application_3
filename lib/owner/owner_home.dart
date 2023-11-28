import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Paint/CustomPaintHome.dart';
import 'package:quickparking_flutter/owner/add_parking.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:quickparking_flutter/Pages/map.dart';
import 'package:quickparking_flutter/Transitions/FadeTransition.dart';
import 'package:quickparking_flutter/Widget/recents.dart';
import 'package:quickparking_flutter/owner/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickparking_flutter/owner/parking_details.dart';
import 'package:quickparking_flutter/owner/edit_parking.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickparking_flutter/Widget/recents.dart';

class OwnerHomePage extends StatefulWidget {
  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: <Widget>[
          TopBar_home(),
          _buildContent(context),
        ],
      ),
      drawer: _buildDrawer(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    Color miColor = Color(0xFFB71C1C);

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.admin_panel_settings_outlined, color: Colors.white),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Recents()));
        },
      ),
      title: Center(
        child: Text(
          'PARQUEOS',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quickstand'),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.assignment_ind, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
      ],
      backgroundColor: miColor,
      elevation: 0,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(
        children: <Widget>[
          _buildSearchBar(context),
          SizedBox(height: 20),
          _buildAddParkingButton(context),
          Expanded(child: _buildParkingList(context)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    void _searchAndNavigate() {
      String searchQuery = searchController.text;
      if (searchQuery.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapView(searchQuery: searchQuery),
          ),
        );
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapView()));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: ListTile(
          title: TextField(
            controller: searchController,
            enabled: true,
            decoration: InputDecoration(
              hintText: '¿A dónde vas?',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                letterSpacing: 0.2,
              ),
              border: InputBorder.none,
            ),
            onSubmitted: (_) => _searchAndNavigate(),
          ),
          trailing: GestureDetector(
            onTap: _searchAndNavigate,
            child: Icon(Icons.search, size: 27, color: Colors.red[700]),
          ),
        ),
      ),
    );
  }

  Widget _buildAddParkingButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddParkingPage())),
      child: Text('Agregar un parqueo nuevo +'),
      style: ElevatedButton.styleFrom(
        primary: Colors.orange[900],
        onPrimary: Colors.black,
      ),
    );
  }

  Widget _buildParkingList(BuildContext context) {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('parqueosgp')
          .where('ownerId', isEqualTo: currentUserId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error al cargar parqueos');
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var parqueo = snapshot.data!.docs[index];
            return Card(
              color: Colors.black,
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: ListTile(
                title: Text(
                  parqueo['nombre'],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  parqueo['ubicacion'],
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ParkingDetailsPage(parqueoId: parqueo.id),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditParkingPage(
                              parqueoId: parqueo.id,
                              onUpdate: () {},
                            ),
                          ),
                        );

                        if (result == 'updated') {
                          setState(() {});
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () => _confirmDeletion(context, parqueo.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _confirmDeletion(BuildContext context, String parqueoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar Eliminación"),
          content: Text("¿Estás seguro de que quieres eliminar este parqueo?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Eliminar"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('parqueosgp')
                    .doc(parqueoId)
                    .delete()
                    .then((_) => Navigator.of(context).pop())
                    .catchError((error) => print("Error al eliminar: $error"));
              },
            ),
          ],
        );
      },
    );
  }
  //

  Drawer _buildDrawer(BuildContext context) {
    // Personaliza tu Drawer aquí
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange[400]),
            child: Text(
              'Menú',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _openNavigationMenu(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
