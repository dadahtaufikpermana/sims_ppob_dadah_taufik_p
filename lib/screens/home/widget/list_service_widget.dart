import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/service_item.dart';

import '../../../utils/provider/service_model_provider.dart'; // Import widget ServiceItem

class ListServiceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context); // Ambil data layanan dari ServiceProvider
    final services = serviceProvider.services;

    final servicesPerRow = 6;
    final rowCount = (services.length / servicesPerRow).ceil();

    return Wrap(
      children: List<Widget>.generate(rowCount, (row) {
        return Row(
          children: services
              .skip(row * servicesPerRow)
              .take(servicesPerRow)
              .map((service) {
            return ServiceItem(service: service);
          }).toList(),
        );
      }).toList(),
    );
  }
}
