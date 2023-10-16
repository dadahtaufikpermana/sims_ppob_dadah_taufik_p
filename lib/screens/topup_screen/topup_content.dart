import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/balance_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/list_item_section_topup.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/nominal_widget.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../utils/provider/user_profile_manager.dart';
import '../../widget/button_widget.dart';

class TopupContent extends StatefulWidget {
  const TopupContent({super.key});

  @override
  State<TopupContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<TopupContent> {
  late UserProfileManager userProfileManager;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _nominalTopup;

  @override
  void initState() {
    super.initState();
    // Mengambil profil user setelah inisialisasi widget
    userProfileManager = UserProfileManager(context);
    _fetchUserProfile();
    _nominalTopup = TextEditingController();
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
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          'Kembali',
                          style: theme.textTheme.headline4!.copyWith(
                            fontSize: 14,
                            color: blackColor20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text(
                          'Top Up',
                          style: theme.textTheme.headline4!.copyWith(
                            fontSize: 14,
                            color: blackColor20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  BalanceWidget(),
                  const SizedBox(height: 40.0),
                  Text(
                    'Silahkan masukan',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 24,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Nominal Top Up',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 30,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Form(
                    key: _formState,
                    child: NominalWidget(
                      nominalController: _nominalTopup,
                    ),
                  ),
                  ListTopUpSection(),

                  const SizedBox(height: 32.0),
                  ButtonWidget(
                    onPress: () => (),
                    title: 'Top Up',
                    buttonColor: Colors.grey,
                    titleColor: whiteColor,
                    borderColor: Colors.grey,
                    paddingHorizontal: 22.0,
                    paddingVertical: 16.0,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
