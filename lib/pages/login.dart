import 'package:flutter/material.dart';

class HolaMundo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola, Mundo'),
      ),
      body: Center(
        child: Text(
          'Hola, mundo',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HolaMundo(),
  ));
}
