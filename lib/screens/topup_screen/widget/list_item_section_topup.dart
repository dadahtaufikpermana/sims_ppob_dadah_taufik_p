import 'package:flutter/material.dart';

import 'item_section_topup.dart';
import 'list_item_section_topup.dart';

class ListTopUpSection extends StatelessWidget {
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
            TopUpItem('Rp. 10.000'),
            TopUpItem('Rp. 20.000'),
            TopUpItem('Rp. 50.000'),
            TopUpItem('Rp. 100.000'),
            TopUpItem('Rp. 200.000'),
            TopUpItem('Rp. 250.000'),
          ],
        ),
      ],
    );
  }
}