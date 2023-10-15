import 'package:flutter/material.dart';

import '../../widget/custom_navigation_bar.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: HomeContent()),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabSelected: _onItemTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}
