import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickparking_flutter/Transitions/SlideTransition.dart';
import 'package:quickparking_flutter/Pages/payment.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DraggableSheet extends StatelessWidget {
  final Map<String, dynamic> parqueoData;

  DraggableSheet({required this.parqueoData}) {
    print("ParqueoData en DraggableSheet: $parqueoData");
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = parqueoData['imagenes'] as List<dynamic>;

    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      maxChildSize: 0.65,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        parqueoData['nombre'],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22.4,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        parqueoData['ubicacion'],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 12,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildVehiclesAllowed(parqueoData['vehiculos']),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        SlideTopRoute(
                          page: MyPaymentPage(parqueoData: parqueoData),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'RESERVA AHORA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
                _buildImages(images),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'DETALLES',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                      fontSize: 20,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    parqueoData['horario'],
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900],
                      fontSize: 19,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Costo por Hora: \$${parqueoData['horaCosto'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900],
                      fontSize: 19,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Espacios Disponibles: ${parqueoData['espaciosDisponibles'].toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900],
                      fontSize: 19,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVehiclesAllowed(Map<String, dynamic> vehicles) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              'Vehículos Permitidos: ',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          if (vehicles['autos']) ...[
            _buildVehicleTypeCard(Icons.local_parking, 'Autos'),
          ],
          if (vehicles['motos']) ...[
            _buildVehicleTypeCard(Icons.motorcycle, 'Motos'),
          ],
          if (vehicles['camiones']) ...[
            _buildVehicleTypeCard(Icons.local_shipping, 'Camiones'),
          ],
        ],
      ),
    );
  }

  Widget _buildVehicleTypeCard(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Icon(icon, size: 16, color: Colors.white),
              SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.4,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        color: Colors.grey[900],
        elevation: 4,
      ),
    );
  }

  Widget _buildImages(List<dynamic> images) {
    return Column(
      children: images.map((imageUrl) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      }).toList(),
    );
  }
}
