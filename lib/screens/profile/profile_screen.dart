import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/profile/profile_content.dart';

import '../../widget/custom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: ProfileContent()),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabSelected: _onItemTapped,
        currentIndex: _currentIndex,
        context: context,
      ),
    );
  }
}
