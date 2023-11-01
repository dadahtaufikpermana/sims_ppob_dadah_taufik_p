import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import NumberFormat

class TopUpItem extends StatelessWidget {
  final int? nominal;
  final Function(int) onPressTopUp;

  TopUpItem(this.nominal, this.onPressTopUp);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressTopUp(nominal!);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          "Rp. " + NumberFormat.decimalPattern('id').format(nominal),
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

