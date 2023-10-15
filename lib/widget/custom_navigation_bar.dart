import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final int currentIndex;

  const CustomBottomNavigationBar({
    Key? key,
    required this.onTabSelected,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
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
      onTap: widget.onTabSelected,
    );
  }
}
