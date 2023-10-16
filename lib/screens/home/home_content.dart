import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/balance_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/list_promo_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/list_service_widget.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../utils/provider/user_profile_manager.dart'; // Import ApiService

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late UserProfileManager userProfileManager;

  @override
  void initState() {
    super.initState();
    // Mengambil profil user setelah inisialisasi widget
    userProfileManager = UserProfileManager(context);
    _fetchUserProfile();
  }

  // Fungsi untuk mengambil profil user
  void _fetchUserProfile() async {
    final preferenceSettingsProvider =
        Provider.of<PreferenceSettingsProvider>(context, listen: false);

    try {
      final jwtToken = preferenceSettingsProvider.jwtToken;
      await userProfileManager.fetchUserProfile(jwtToken!);
    } catch (error) {
      // Handle error
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/mobile_assets/Logo.png',
                          height: 18, width: 18),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          'SIMS PPOB',
                          style: theme.textTheme.headline4!.copyWith(
                            fontSize: 14,
                            color: blackColor20,
                          ),
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        // preferenceSettingsProvider.profileImage ??
                        'assets/mobile_assets/Profile Photo-1.png',
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    'Selamat Datang,',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 24,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${preferenceSettingsProvider.firstName} ${preferenceSettingsProvider.lastName},',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 30,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  BalanceWidget(),
                  const SizedBox(height: 38.0),
                  ListServiceWidget(),
                  Text(
                    'Temukan Promo Terbaik',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 12,
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                  ListPromoWidget(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
