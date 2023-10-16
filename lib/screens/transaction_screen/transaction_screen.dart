import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/topup_content.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/item_section_topup.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/transaction_screen/transaction_content.dart';

import '../../widget/custom_navigation_bar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TopupScreenState createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TransactionScreen> {
  int _currentIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: TransactionContent()),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabSelected: _onItemTapped,
        currentIndex: _currentIndex,
        context: context,
      ),
    );
  }
}
