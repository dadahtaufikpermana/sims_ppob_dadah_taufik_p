import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';

import '../../../utils/style.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
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
                        text: obscureText ? "Rp " + '●' * 6 : 'Rp '+'200.000',
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
                        obscureText ? Icons.visibility_off : Icons.visibility,
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
  }
}
