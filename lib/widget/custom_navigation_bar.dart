import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/routes/routes.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final int currentIndex;
  final BuildContext context;

  const CustomBottomNavigationBar({
    Key? key,
    required this.onTabSelected,
    required this.currentIndex,
    required this.context,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void onItemTapped(int index) {
    if (index != widget.currentIndex) {
      if (index == 0) {
        Navigator.pushNamed(
          widget.context,
          Routes.homeScreen,
        );
      } else if (index == 1) {
        Navigator.pushNamed(
          widget.context,
          Routes.topupScreen,
        );
      } else if (index == 2) {
      } else if (index == 3) {
      } else {
        setState(() {
          widget.onTabSelected(index);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart_outlined),
          label: 'Topup',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: 'Transaction',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Akun',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
