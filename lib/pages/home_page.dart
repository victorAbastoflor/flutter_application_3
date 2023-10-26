import 'package:flutter/material.dart';

//service of firebase
import 'package:flutter_application_3/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista de Usuarios'),
      ),
      body: FutureBuilder(
        future: getPersona(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final nombre = snapshot.data?[index]['nombre'];
                final apellidoPaterno =
                    snapshot.data?[index]['ApellidoPaterno'];
                final nombreCompleto = '$nombre $apellidoPaterno';

                return Dismissible(
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:
                                const Text("¿Seguro de eliminar el usuario?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancelar")),
                              TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, true);
                                  },
                                  child: const Text("Aceptar"))
                            ],
                          );
                        });
                    return result;
                  },
                  background: Container(
                    child: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    title: Text(nombreCompleto),
                    onTap: () async {
                      await Navigator.pushNamed(context, '/edit', arguments: {
                        "nombre": snapshot.data?[index]['nombre'],
                        "ApellidoPaterno": snapshot.data?[index]
                            ['ApellidoPaterno'],
                        "ApellidoMaterno": snapshot.data?[index]
                            ['ApellidoMaterno'],
                        "CarnetIdentidad": snapshot.data?[index]
                            ['CarnetIdentidad'],
                        "CorreoElectronico": snapshot.data?[index]
                            ['CorreoElectronico'],
                        "Genero": snapshot.data?[index]['Genero'],
                        "uid": snapshot.data?[index]['uid']
                      });
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
