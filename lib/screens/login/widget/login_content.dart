import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';

import '../../../routes/routes.dart';
import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/button_widget.dart';
import 'login_form_widget.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void onPressSignInButton() {
    if (_formState.currentState?.validate() == true) {
      context.showCustomFlashMessage(
        status: 'success',
        title: 'Login Success!',
        positionBottom: false,
      );
      Future.delayed(const Duration(seconds: 1)).then(
            (_) => Navigator.pushNamed(
          context,
          Routes.homeScreen,
        ),
      );
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
            const SizedBox(height: 160.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/mobile_assets/Logo.png',
                          height: 28, width: 28),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          'SIMS PPOB',
                          style: theme.textTheme.headline4!.copyWith(
                            fontSize: 24,
                            color: blackColor20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    'Masuk atau buat akun untuk memulai',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 32,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 38.0),
                  Form(
                    key: _formState,
                    child: LoginFormWidget(
                      emailController: _email,
                      passwordController: _password,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  ButtonWidget(
                    onPress: () => onPressSignInButton(),
                    title: 'Masuk',
                    buttonColor: Colors.redAccent,
                    titleColor: whiteColor,
                    borderColor: orangeColor,
                    paddingHorizontal: 22.0,
                    paddingVertical: 16.0,
                  ),
                  const SizedBox(height: 36.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun? registrasi",
                        style: context.theme.textTheme.subtitle2!.copyWith(
                          color: blackColor20,
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.registrationScreen,
                        ),
                        child: Text(
                          ' di sini',
                          style: TextStyle(
                            color: orangeColor,
                            fontSize: 12,
                            decorationColor: orangeColor,
                            decorationThickness: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
