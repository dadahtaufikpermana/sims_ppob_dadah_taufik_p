import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/transaction_screen/widget/list_transaction_item.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../utils/provider/transaction_history_provider.dart';
import '../../utils/provider/user_profile_manager.dart';

class TransactionContent extends StatefulWidget {
  const TransactionContent({Key? key}) : super(key: key);

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
  late UserProfileManager userProfileManager;
  bool isFetchingData = false;
  int currentOffset = 0;
  int currentLimit = 5;

  @override
  void initState() {
    super.initState();
    userProfileManager = UserProfileManager(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        final preferenceSettingsProvider =
            Provider.of<PreferenceSettingsProvider>(context, listen: false);
        final jwtToken = preferenceSettingsProvider.jwtToken;
        final transactionProvider =
            Provider.of<TransactionHistoryProvider>(context);

        if (jwtToken != null) {
          if (!isFetchingData) {
            // Jika belum mengambil data, panggil fetchTransactionHistory
            isFetchingData = true;
            transactionProvider.fetchData(
              jwtToken,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            'Kembali',
                            style: theme.textTheme.headline4!.copyWith(
                              fontSize: 14,
                              color: blackColor20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 70.0),
                          child: Text(
                            'Transaksi',
                            style: theme.textTheme.headline4!.copyWith(
                              fontSize: 14,
                              color: blackColor20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // BalanceWidget(),
                    const SizedBox(height: 40.0),
                    Text(
                      'Transaksi',
                      style: theme.textTheme.headline4!.copyWith(
                        fontSize: 24,
                        color: blackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4.0),
                    transactionProvider.transactionHistory.isNotEmpty
                        ? TransactionList()
                        : Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Center(
                              child: Text(
                                'Maaf, tidak ada riwayat transaksi saat ini.',
                                style: theme.textTheme.headline4!.copyWith(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                    const SizedBox(height: 4.0),
                    if (transactionProvider.transactionHistory.isNotEmpty)
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            final transactionProvider =
                                Provider.of<TransactionHistoryProvider>(context,
                                    listen: false);
                            transactionProvider.fetchData(jwtToken,
                                offset: currentOffset, limit: currentLimit);
                            currentOffset += currentLimit;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Show more',
                              style: theme.textTheme.headline4!.copyWith(
                                fontSize: 14,
                                color: Colors.redAccent,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // Tampilkan Widget atau pesan ketika jwtToken == null
          return Center(
            child: Text(
              'Anda belum masuk. Silakan login terlebih dahulu.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }
      },
    );
  }
}
