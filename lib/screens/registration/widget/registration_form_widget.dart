import 'package:flutter/material.dart';
import 'package:inspection/inspection.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/access_form_field.dart';
import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../widget/form_label_field_widget.dart';

class RegistrationFormWidget extends StatefulWidget {
  final TextEditingController emailController, passwordController, firstNameController, lastNameController, confirmEmailController ;

  const RegistrationFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.confirmEmailController,
  });

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccesorFormFiled(
              hintText: 'masukan email anda',
              controller: widget.emailController,
              validator: (e) => inspection(
                e,
                'required|email',
                message: 'Kolom email harus di isi dan di isi dengan email',
              ),
              prefixIcon: Icon(Icons.alternate_email),
              child: const FormLabelFieldWidget(),
            ),
            AccesorFormFiled(
              hintText: 'masukan nama depan',
              controller: widget.firstNameController,
              validator: (e) => inspection(
                e,
                'required',
                message: 'Kolom nama depan harus di isi',
              ),
              prefixIcon: Icon(Icons.person_2_outlined),
              child: const FormLabelFieldWidget(),
            ),
            AccesorFormFiled(
              hintText: 'masukan nama belakang',
              controller: widget.lastNameController,
              prefixIcon: Icon(Icons.person_2_outlined),
              child: const FormLabelFieldWidget(),
            ),
            AccesorFormFiled(
              hintText: 'masukan password anda',
              controller: widget.passwordController,
              obscureText: passwordVisible,
              showObscureToggle: true,
              onPressSufixobscureTextIcon: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              textInputAction: TextInputAction.done,
              validator: (e) => inspection(
                e,
                'required',
                message: 'Password harus di isi',
                locale: Intl.getCurrentLocale(),
              ),
              prefixIcon: Icon(Icons.lock_outline),
              child: const FormLabelFieldWidget(),
            ),
            AccesorFormFiled(
              hintText: 'konfirmasi password',
              controller: widget.confirmEmailController,
              obscureText: passwordVisible,
              showObscureToggle: true,
              onPressSufixobscureTextIcon: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              textInputAction: TextInputAction.done,
              validator: (confirmPassword) {
                if (confirmPassword!.isEmpty) {
                  return 'Harus konfirmasi password';
                } else if (confirmPassword != widget.passwordController.text) {
                  return 'Password tidak sama';
                }
                return null;
              },
              prefixIcon: Icon(Icons.lock_outline),
              child: const FormLabelFieldWidget(),
            ),
          ],
        );
      },
    );
  }
}
