import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/routes/register_routes.dart';
import 'package:sims_ppob_dadah_taufik_p/routes/routes.dart';
import 'package:sims_ppob_dadah_taufik_p/utils/navigation.dart';
import 'package:sims_ppob_dadah_taufik_p/utils/provider/prefference_setting_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferenceSettingsProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return MaterialApp(
          title: 'SIMS PPOB',
          theme: ThemeData.light(),
          navigatorKey: navigatorKey,
          initialRoute: Routes.loginScreen,
          routes: routesApp,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
