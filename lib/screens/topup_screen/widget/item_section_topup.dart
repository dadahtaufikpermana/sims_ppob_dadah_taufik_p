import 'package:flutter/material.dart';

class TopUpItem extends StatelessWidget {
  final String nominal;
  final Function(String) onPressTopUp;

  TopUpItem(this.nominal, this.onPressTopUp);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressTopUp(nominal); // Panggil onPressTopUp dengan nilai nominal yang dipilih
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          nominal,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
