import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/balance_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/home/widget/payment_form_widget.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/list_item_section_topup.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/topup_screen/widget/nominal_widget.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../data/api/api_service.dart';
import '../../utils/provider/user_profile_manager.dart';
import '../../widget/button_widget.dart';
import '../../widget/custom_dialog.dart';

class PaymentContent extends StatefulWidget {
  const PaymentContent({Key? key}) : super(key: key);

  @override
  State<PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {
  late UserProfileManager userProfileManager;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _paymentController;
  double? selectedNominal;
  String? selectedServiceIcon;
  String? selectedServiceName;
  int? serviceTariff;
  String? selectedServiceCode;

  @override
  void initState() {
    super.initState();
    userProfileManager = UserProfileManager(context);
    _paymentController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    final dynamic args = ModalRoute.of(context)!.settings.arguments;
    if (args is Map<String, dynamic>) {
      selectedServiceIcon = args['icon'];
      selectedServiceName = args['name'];
      serviceTariff = args['tariff'];
      selectedServiceCode = args['code'];
      print('serviceTariff in PaymentContent: $serviceTariff $selectedServiceName');

    }

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
                          'Pembayaran',
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
                    'Bayar',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 16,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Image.network(selectedServiceIcon ?? ''), // Menampilkan ikon layanan
                      Text(
                        selectedServiceName ?? '',
                        style: theme.textTheme.headline4!.copyWith(
                          fontSize: 16,
                          color: blackColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Form(
                    key: _formState,
                    child: PaymentFormWidget(
                      paymentController: _paymentController,
                      serviceTariff: serviceTariff,
                    ),
                  ),

                  const SizedBox(height: 32.0),
                  ButtonWidget(
                    onPress: (){
                      showCustomDialog(context, serviceTariff!, selectedServiceName!, selectedServiceCode!);
                    },
                    title: 'Bayar',
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
