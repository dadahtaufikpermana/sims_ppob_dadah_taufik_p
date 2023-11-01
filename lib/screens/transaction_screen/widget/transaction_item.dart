import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final String description;
  final int totalAmount;
  final String createdOn;
  final String transactionType;

  TransactionItem({
    required this.description,
    required this.totalAmount,
    required this.createdOn,
    required this.transactionType,
  });

  String formattedDate(String createdOn) {
    DateTime dateTime = DateTime.parse(createdOn);
    String formattedDate = "${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year} ${dateTime.hour}:${dateTime.minute} WIB";
    return formattedDate;
  }

  String _getMonthName(int month) {
    final monthNames = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
    return monthNames[month - 1];
  }
  @override
  Widget build(BuildContext context) {
    Color amountColor = Colors.green;
    String amountText =  "+ Rp." + NumberFormat.decimalPattern('id').format(totalAmount);

    if (transactionType == 'PAYMENT') {
      amountColor = Colors.red;
      amountText = "-  Rp. " + NumberFormat.decimalPattern('id').format(totalAmount);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amountText,
                style: TextStyle(
                  fontSize: 18,
                  color: amountColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  formattedDate(createdOn),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
