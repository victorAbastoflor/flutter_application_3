import 'package:flutter/material.dart';
import 'package:quickparking_flutter/Pages/payment.dart';
import 'package:quickparking_flutter/owner/owner_home.dart';

class MyRecipt extends StatefulWidget {
  final Map<String, dynamic> reservaData;

  MyRecipt({required this.reservaData});

  @override
  State createState() => _MyReciptState();
}

class _MyReciptState extends State<MyRecipt> {
  @override
  Widget build(BuildContext context) {
    String nombreCompleto =
        widget.reservaData['nombreCompleto'] ?? 'No especificado';
    String numeroCelular = widget.reservaData['numTel'] ?? 'No especificado';
    String nit = widget.reservaData['nit'] ?? 'No especificado';
    String placaVehiculo =
        widget.reservaData['placaVehiculo'] ?? 'No especificado';
    String horas = widget.reservaData['horas']?.toString() ?? 'No especificado';
    String totalPagar = widget.reservaData['total'] ?? 'No especificado';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context, true),
                    child: Icon(Icons.clear, color: Colors.black, size: 22),
                  ),
                  SizedBox(width: 100),
                  Center(
                    child: Text(
                      'Parking Code',
                      style: TextStyle(
                          fontSize: 24.4,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Center(
                child: Image.asset(
                  'image/qr_code.jpg',
                  width: 220,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: _buildInfoRow('Nombre',
                    widget.reservaData['nombreCompleto'] ?? 'No especificado'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: _buildInfoRow('Teléfono',
                    widget.reservaData['numTel'] ?? 'No especificado'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: _buildInfoRow(
                    'NIT', widget.reservaData['nit'] ?? 'No especificado'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: _buildInfoRow('Placa Vehículo',
                    widget.reservaData['placaVehiculo'] ?? 'No especificado'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: _buildInfoRow(
                    'Horas',
                    widget.reservaData['horas']?.toString() ??
                        'No especificado'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: _buildInfoRow('Total a Pagar',
                    '\$${widget.reservaData['total'] ?? 'No especificado'}'),
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Dirección del Parqueo',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                      fontSize: 13,
                      letterSpacing: 0.2),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.reservaData['ubicacion'] ?? 'Dirección no disponible',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900],
                      fontSize: 16.4,
                      letterSpacing: 0.2),
                ),
              ),
              SizedBox(height: 144),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 6,
                    ),
                    onPressed: () {
                      // Navegar a HomePage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OwnerHomePage()),
                      );
                    },
                    child: Text(
                      'INICIO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        wordSpacing: 2,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
                fontSize: 13)),
        Text(value,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
      ],
    );
  }
}
