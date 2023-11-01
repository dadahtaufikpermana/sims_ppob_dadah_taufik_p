import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../utils/provider/prefference_setting_provider.dart';
import 'custom_payment_dialog.dart';

class CustomDialog extends StatelessWidget {
  final int? serviceTariff;
  final String? selectedServiceName;
  final String? selectedServiceCode;
  final int? balance;
  final double width;

  CustomDialog(
      {this.serviceTariff,
      this.selectedServiceName,
      this.selectedServiceCode,
      this.balance,
      required this.width});

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
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Image.asset(
              'assets/mobile_assets/Logo.png',
              height: 40,
              width: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text('Bayar ${selectedServiceName} senilai'),
          ),
          Text(
            "Rp. " + serviceTariff.toString() + "?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          TextButton(
            onPressed: () async {
              final preferenceSettingsProvider =
              Provider.of<PreferenceSettingsProvider>(context, listen: false);
              final jwtToken = preferenceSettingsProvider.jwtToken;
              final serviceCode = selectedServiceCode;
              final saldoBalance = preferenceSettingsProvider.balance;

              if (jwtToken != null && serviceCode != null) {
                final transactionAmount = serviceTariff;
                if (saldoBalance != null && transactionAmount != null) {
                  final perbandingan = saldoBalance <= transactionAmount;

                  if (perbandingan) {
                    // Jika saldo tidak mencukupi, tampilkan pesan "Saldo Kurang"
                    print('Saldo Kurang.');
                    Future.delayed(Duration.zero, () {
                      showCustomPaymentDialog(context, serviceTariff!,
                          selectedServiceName!, "Gagal, Saldo Kurang");
                    });
                  } else {
                    // Lanjutkan dengan transaksi jika saldo mencukupi
                    try {
                      final transactionModel = await ApiService()
                          .postTransaction(jwtToken, serviceCode);

                      if (transactionModel != null &&
                          transactionModel.status == 0) {
                        // Jika transaksi berhasil, menampilkan pesan "Transaksi Berhasil"
                        print(
                            'Transaksi berhasil. Total Amount: Rp. $transactionAmount');
                        Future.delayed(Duration.zero, () {
                          showCustomPaymentDialog(context, serviceTariff!,
                              selectedServiceName!, "Transaksi Berhasil");
                        });
                      } else {
                        // Jika transaksi gagal, akan menampilkan pesan "Transaksi Gagal"
                        print('Transaksi gagal.');
                        Future.delayed(Duration.zero, () {
                          showCustomPaymentDialog(context, serviceTariff!,
                              selectedServiceName!, "Transaksi Gagal");
                        });
                      }
                    } catch (success) {
                      Future.delayed(Duration.zero, () {
                        showCustomPaymentDialog(context, serviceTariff!,
                            selectedServiceName!, "Transaksi Berhasil");
                      });
                    }
                  }
                } else {
                  print('Saldo atau Amount tidak valid.');
                }
              } else {
                print('Terjadi kesalahan');
              }
            },
            child: Text(
              'Ya, Lanjutkan Bayar',
              style: TextStyle(color: Colors.red),
            ),
          ),

          SizedBox(width: 24),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Batalkan',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomDialog(BuildContext context, int serviceTariff,
    String selectedServiceName, String selectedServiceCode) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
          serviceTariff: serviceTariff,
          selectedServiceName: selectedServiceName,
          selectedServiceCode: selectedServiceCode,
          width: 380);
    },
  );
}
