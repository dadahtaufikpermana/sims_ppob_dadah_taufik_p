import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/balance_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/list_item_section_topup.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/nominal_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/transaction_screen/widget/list_transaction_item.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../data/api/api_service.dart';
import '../../utils/provider/user_profile_manager.dart';
import '../../widget/button_widget.dart';

class TransactionContent extends StatefulWidget {
  const TransactionContent({Key? key}) : super(key: key);

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
  late UserProfileManager userProfileManager;

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
                  BalanceWidget(),
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
                  TransactionList(),
                  const SizedBox(height: 4.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Show more',
                      style: theme.textTheme.headline4!.copyWith(
                        fontSize: 14,
                        color: Colors.redAccent,
                        decorationThickness: 2
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
