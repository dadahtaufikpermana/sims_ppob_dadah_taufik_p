import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/payment_content.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/topup_content.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/item_section_topup.dart';

import '../../widget/custom_navigation_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreen createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: PaymentContent()),
    );
  }
}
