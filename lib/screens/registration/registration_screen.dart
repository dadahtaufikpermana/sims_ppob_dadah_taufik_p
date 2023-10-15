import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/registration/registration_content.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: const SingleChildScrollView(
            child: RegistrationContent(),
          ),
        ),
      ),
    );
  }
}
