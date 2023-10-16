import 'package:flutter/material.dart';
import 'item_section_topup.dart';

class ListTopUpSection extends StatelessWidget {
  final Function(String) onPressTopUp;

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
          children: [
            TopUpItem('Rp. 10.000', onPressTopUp),
            TopUpItem('Rp. 20.000', onPressTopUp),
            TopUpItem('Rp. 50.000', onPressTopUp),
            TopUpItem('Rp. 100.000', onPressTopUp),
            TopUpItem('Rp. 200.000', onPressTopUp),
            TopUpItem('Rp. 250.000', onPressTopUp),
          ],
        ),
      ],
    );
  }
}
