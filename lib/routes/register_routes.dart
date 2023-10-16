import 'package:flutter/widgets.dart';
import 'package:sims_ppob_dadah_taufik_p/routes/routes.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/home_screen.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/payment_screen.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/profile/profile_screen.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/registration/registration_screen.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/splash_screen.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/topup_screen.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/transaction_screen/transaction_screen.dart';

import '../screens/login/login_screen.dart';

Map<String, WidgetBuilder> routesApp = {
  Routes.loginScreen: (_) => const LoginScreen(),
  Routes.registrationScreen: (_) => const RegisterScreen(),
  Routes.homeScreen: (_) => const HomeScreen(),
  Routes.topupScreen: (_) => const TopupScreen(),
  Routes.transactionScreen: (_) => const TransactionScreen(),
  Routes.profileScreen: (_) => const ProfileScreen(),
  Routes.paymentScreen: (_) => const PaymentScreen(),
  Routes.splashScreen: (_) => const SplashScreen()
};
