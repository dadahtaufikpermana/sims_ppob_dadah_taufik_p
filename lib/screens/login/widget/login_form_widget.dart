import 'package:flutter/material.dart';
import 'package:inspection/inspection.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/access_form_field.dart';
import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../widget/form_label_field_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final TextEditingController emailController, passwordController;

  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
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
            const SizedBox(height: 20.0),
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
              validator: (password) {
                if (password!.isEmpty) {
                  return 'Password harus diisi';
                } else if (password.length < 8) {
                  return 'Panjang password harus minimal 8 karakter';
                }
                return null; // Password valid
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
