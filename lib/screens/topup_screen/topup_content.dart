import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/balance_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/list_item_section_topup.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/nominal_widget.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../data/api/api_service.dart';
import '../../utils/provider/user_profile_manager.dart';
import '../../widget/button_widget.dart';

class TopupContent extends StatefulWidget {
  const TopupContent({Key? key}) : super(key: key);

  @override
  State<TopupContent> createState() => _TopupContentState();
}

class _TopupContentState extends State<TopupContent> {
  late UserProfileManager userProfileManager;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _nominalTopup;
  double? selectedNominal;

  @override
  void initState() {
    super.initState();
    userProfileManager = UserProfileManager(context);
    _nominalTopup = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTopUpSelected(int nominal) {
    setState(() {
      selectedNominal = nominal.toDouble();
      _nominalTopup.text = nominal.toString();
    });
  }

  void onPressTopUpButton() async {
    if (_formState.currentState?.validate() == true) {
      final apiService = ApiService();
      final preferenceSettingsProvider = Provider.of<PreferenceSettingsProvider>(context, listen: false);
      final jwtToken = preferenceSettingsProvider.jwtToken; // Mengambil jwtToken dari PreferenceSettingsProvider
      userProfileManager.fetchBalance(jwtToken!);

      if (jwtToken != null) {
        double topUpAmount = double.tryParse(_nominalTopup.text) ?? 0.0;

        if (topUpAmount < 10000) {
          context.showCustomFlashMessage(
            status: 'error',
            title: 'Minimal topup adalah 10.000',
            positionBottom: false,
          );
          return;
        }

        try {
          await apiService.doTopUp(jwtToken as String, topUpAmount);

          context.showCustomFlashMessage(
            status: 'success',
            title: 'Top Up Berhasil!',
            positionBottom: false,
          );
          _nominalTopup.clear();
        } catch (error) {
          context.showCustomFlashMessage(
            status: 'error',
            title: error.toString(),
            positionBottom: false,
          );
        }
      } else {
        context.showCustomFlashMessage(
          status: 'error',
          title: 'Token JWT tidak tersedia',
          positionBottom: false,
        );
      }
    }
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
                  BalanceWidget(jwtToken: preferenceSettingsProvider.jwtToken ?? "DefaultString"),
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
                  ListTopUpSection(
                    onPressTopUp: (nominal) {
                      _nominalTopup.text = nominal;
                      onPressTopUpButton();
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ButtonWidget(
                    onPress: _nominalTopup.text.isNotEmpty ? onPressTopUpButton! : () {},
                    title: 'Top Up',
                    buttonColor: selectedNominal != null
                        ? theme.primaryColor
                        : Colors.grey,
                    titleColor: whiteColor,
                    borderColor: selectedNominal != null
                        ? theme.primaryColor
                        : Colors.grey,
                    paddingHorizontal: 22.0,
                    paddingVertical: 16.0,
                  )


                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
