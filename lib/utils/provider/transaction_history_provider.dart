import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../data/models/transaction_model_history.dart';

class TransactionHistoryProvider with ChangeNotifier {
  List<TransactionRecord> _transactionHistory = [];

  List<TransactionRecord> get transactionHistory => _transactionHistory;

  Future<void> fetchData(String jwtToken,
      {int offset = 0, int limit = 5}) async {
    print('Offset: $offset, Limit: $limit');
    final url = Uri.parse(
        'https://take-home-test-api.nutech-integrasi.app/transaction/history?offset=$offset&limit=$limit');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Response from server: $jsonResponse');
        final transactionResponse = TransactionResponse.fromJson(jsonResponse);

        final newRecords = transactionResponse.data.records;

        if (newRecords.isNotEmpty) {
          if (offset == 0) {
            _transactionHistory = newRecords;
          } else {
            _transactionHistory.addAll(newRecords);
          }
          // Perbarui offset dengan benar
        } else {
          // Tidak ada data baru yang dimuat, mungkin akhir data
        }

        notifyListeners();
      } else {
        throw Exception(
            'Gagal mengambil data transaksi: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal mengambil data transaksi: $error');
    }
  }
}
