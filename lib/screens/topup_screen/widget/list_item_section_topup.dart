import 'package:flutter/material.dart';

import 'item_section_topup.dart';

class ListTopUpSection extends StatelessWidget {
  final Function(int) onPressTopUp;

  ListTopUpSection({required this.onPressTopUp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 2.0,
          mainAxisSpacing: 16.0, // Jarak antara baris (vertikal)
          crossAxisSpacing: 8.0, // Jarak antara item secara horizontal
          children: [
            TopUpItem(10000, onPressTopUp),
            TopUpItem(20000, onPressTopUp),
            TopUpItem(50000, onPressTopUp),
            TopUpItem(100000, onPressTopUp),
            TopUpItem(200000, onPressTopUp),
            TopUpItem(250000, onPressTopUp),
          ],
        ),
      ],
    );
  }
}
