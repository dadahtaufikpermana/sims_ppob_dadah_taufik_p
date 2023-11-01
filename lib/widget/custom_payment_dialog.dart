import 'package:flutter/material.dart';

import '../routes/routes.dart';

class CustomPaymentDialog extends StatelessWidget {
  final int? serviceTariff;
  final String? selectedServiceName;
  final String? resultTransaction;
  final IconData? icon;
  final Color? iconColor;

  CustomPaymentDialog({
    this.serviceTariff,
    this.selectedServiceName,
    required this.resultTransaction,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: 230,
      width: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Icon(
              icon ??
                  (resultTransaction == "Transaksi Berhasil"
                      ? Icons.check_circle
                      : Icons.cancel),
              color: iconColor ??
                  (resultTransaction == "Transaksi Berhasil"
                      ? Colors.green
                      : Colors.red),
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text('Bayar ${selectedServiceName} senilai'),
          ),
          Text(
            "Rp. " + serviceTariff.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              resultTransaction!,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () {
              Future.delayed(const Duration(seconds: 0)).then(
                (_) => Navigator.pushNamed(
                  context,
                  Routes.homeScreen,
                ),
              );
            },
            child: Text(
              'Kembali ke Beranda',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomPaymentDialog(BuildContext context, int serviceTariff,
    String selectedServiceName, String resultTransaction,
    {IconData? icon, Color? iconColor}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPaymentDialog(
        serviceTariff: serviceTariff,
        selectedServiceName: selectedServiceName,
        resultTransaction: resultTransaction,
        icon: icon,
        iconColor: iconColor,
      );
    },
  );
}
