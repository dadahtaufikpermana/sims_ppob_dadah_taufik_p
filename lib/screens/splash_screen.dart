import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, Routes.loginScreen);
    });

    return EasySplashScreen(
      logo: Image.asset('assets/mobile_assets/Logo.png'),
      title: Text(
        "Dadah Taufik Permana",
        style: TextStyle(
            fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      loadingText: const Text("Loading"),
      durationInSeconds: 4,
    );
  }
}
