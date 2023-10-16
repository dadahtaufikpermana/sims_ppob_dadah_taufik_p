import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/data/models/service_model.dart';

import '../../../routes/routes.dart';

class ServiceItem extends StatelessWidget {
  final ServiceModel service;

  ServiceItem({required this.service});

  @override
  Widget build(BuildContext context) {
    final firstWord = service.serviceName.split(' ')[0]; // Mengambil kata pertama karena data actual nya terlalu panjang

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.paymentScreen,
          arguments: {
            'icon': service.serviceIcon,
            'name': service.serviceName,
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(service.serviceIcon),
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.center,
            child: Text(
              firstWord,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
