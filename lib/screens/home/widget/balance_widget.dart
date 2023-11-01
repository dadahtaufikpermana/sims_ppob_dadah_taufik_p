import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/provider/user_profile_manager.dart';
import '../../../utils/style.dart';

class BalanceWidget extends StatefulWidget {
  final String jwtToken;

  BalanceWidget({required this.jwtToken});

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  bool obscureText = true;
  int? balance;

  void initState() {
    super.initState();
    _fetchBalance();
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  // Metode untuk mengambil saldo
  void _fetchBalance() {
    final userProfileManager = Provider.of<UserProfileManager>(context, listen: false);
    final preferenceSettingsProvider = Provider.of<PreferenceSettingsProvider>(context, listen: false);
    final jwtToken = preferenceSettingsProvider.jwtToken; // Mengambil jwtToken dari PreferenceSettingsProvider
    userProfileManager.fetchBalance(jwtToken!);
  }



  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    // Consumer untuk rebuild jika ada changes di saldo/balance
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        balance = preferenceSettingsProvider.balance;
        final currencyFormat = NumberFormat.currency(locale: 'id', symbol: 'Rp.');

        return Stack(
          children: <Widget>[
            Image.asset('assets/mobile_assets/Background Saldo.png'),
            Positioned(
              top: 30,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Saldo Anda',
                      style: theme.textTheme.headline4!.copyWith(
                        fontSize: 16,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: obscureText
                                ? "Rp " + '●' * (balance != null ? balance.toString().length : 1)
                                : currencyFormat.format(balance ?? 0),
                            style: theme.textTheme.headline4!.copyWith(
                              fontSize: 24,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Lihat Saldo',
                        style: theme.textTheme.headline4!.copyWith(
                          fontSize: 12,
                          color: whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: toggleObscureText,
                          child: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: whiteColor,
                            size: 14,
                          ),
                        ),
                      )
                    ],
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
