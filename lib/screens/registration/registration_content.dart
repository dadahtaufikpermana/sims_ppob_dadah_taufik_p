import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/registration/widget/registration_form_widget.dart';

import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../utils/style.dart';
import '../../../widget/button_widget.dart';
import '../../data/api/api_service.dart';
import '../../routes/routes.dart';

class RegistrationContent extends StatefulWidget {
  const RegistrationContent({super.key});

  @override
  State<RegistrationContent> createState() => _RegistrationContentState();
}

class _RegistrationContentState extends State<RegistrationContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _confirmPassword;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void onPressSignInButton() async {
    if (_formState.currentState?.validate() == true) {
      final apiService = ApiService();

      try {
        final response = await apiService.registerUser(
          email: _email.text,
          firstName: _firstName.text,
          lastName: _lastName.text,
          password: _password.text,
        );

        if (response['status'] == 0) {
          context.showCustomFlashMessage(
            status: 'success',
            title: 'Registrasi berhasil. Silakan login.',
            positionBottom: false,
          );
          Navigator.pushNamed(context, Routes.loginScreen);
        } else {
          context.showCustomFlashMessage(
            status: 'error',
            title: response['message'],
            positionBottom: false,
          );
        }
      } catch (error) {
        context.showCustomFlashMessage(
          status: 'error',
          title: 'Gagal melakukan registrasi.',
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
            const SizedBox(height: 80.0),
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
                    'Lengkapi data untuk membuat akun',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 32,
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 38.0),
                  Form(
                    key: _formState,
                    child: RegistrationFormWidget(
                      emailController: _email,
                      passwordController: _password,
                      firstNameController: _firstName,
                      lastNameController: _lastName,
                      confirmEmailController: _confirmPassword,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  ButtonWidget(
                    onPress: () => onPressSignInButton(),
                    title: 'Registrasi',
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
                        "Sudah punya akun? login",
                        style: context.theme.textTheme.subtitle2!.copyWith(
                          color: blackColor20,
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.loginScreen,
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
