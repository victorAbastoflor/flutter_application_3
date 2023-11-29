import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DBparkeosRecord.dart'; // Importa la clase DBparkeosRecord

class CompoWidget extends StatefulWidget {
  final DocumentReference ubicacionref;

  CompoWidget({Key? key, required this.ubicacionref}) : super(key: key);

  @override
  _CompoWidgetState createState() => _CompoWidgetState();
}

class _CompoWidgetState extends State<CompoWidget> {
  late DBparkeosRecord _dbParkeosRecord;

  @override
  void initState() {
    super.initState();
    loadDBParkeosRecord();
  }

  Future<void> loadDBParkeosRecord() async {
    _dbParkeosRecord = await DBparkeosRecord.getDocument(widget.ubicacionref);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Nombre: ${_dbParkeosRecord.nombre ?? 'No disponible'}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text('Dirección: ${_dbParkeosRecord.direccion ?? 'No disponible'}'),
          Text(
              'Número de Plazas: ${_dbParkeosRecord.numplazas ?? 'No disponible'}'),
          Text('Precio: ${_dbParkeosRecord.precio ?? 'No disponible'}'),
          // Puedes mostrar otros datos de la misma manera
        ],
      ),
    );
  }
}
