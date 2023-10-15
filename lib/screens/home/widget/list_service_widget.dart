import 'package:flutter/material.dart';

class ListServiceWidget extends StatelessWidget {
  //untuk slicing sementara
  @override
  Widget build(BuildContext context) {
    final servicesPerRow = 6;
    final rowCount = (services.length / servicesPerRow).ceil();

    return Wrap(
      children: List<Widget>.generate(rowCount, (row) {
        return Row(
          children: services
              .skip(row * servicesPerRow)
              .take(servicesPerRow)
              .map((service) {
            return GestureDetector(
              onTap: () {},
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
                    child: Image.asset(service.icon),
                  ),
                  SizedBox(height: 8),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      service.name,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class Service {
  final String icon;
  final String name;

  Service(this.icon, this.name);
}

final services = [
  Service("assets/mobile_assets/PBB.png", 'PBB'),
  Service('assets/mobile_assets/Listrik.png', 'Listrik'),
  Service('assets/mobile_assets/Pulsa.png', 'Pulsa'),
  Service('assets/mobile_assets/PDAM.png', 'PDAM'),
  Service('assets/mobile_assets/PGN.png', 'PGN'),
  Service('assets/mobile_assets/Televisi.png', 'Televisi'),
  Service('assets/mobile_assets/Musik.png', 'Musik'),
  Service('assets/mobile_assets/Game.png', 'Game'),
  Service('assets/mobile_assets/Makanan.png', 'Makanan'),
  Service('assets/mobile_assets/Kurban.png', 'Kurban'),
  Service('assets/mobile_assets/Zakat.png', 'Zakat'),
  Service('assets/mobile_assets/Data.png', 'Data'),
];
