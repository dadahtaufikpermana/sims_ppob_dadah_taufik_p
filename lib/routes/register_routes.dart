import 'package:flutter/widgets.dart';
import 'package:sims_ppob_dadah_taufik_p/routes/routes.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/home_screen.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/registration/registration_screen.dart';

import '../screens/login/login_screen.dart';

Map<String, WidgetBuilder> routesApp = {
  Routes.loginScreen: (_) => const LoginScreen(),
  Routes.registrationScreen: (_) => const RegisterScreen(),
  Routes.homeScreen: (_) => const HomeScreen()
};
