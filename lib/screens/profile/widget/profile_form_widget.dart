import 'package:flutter/material.dart';
import 'package:inspection/inspection.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/access_form_field.dart';
import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../widget/form_label_field_widget.dart';

class ProfileFormWidget extends StatefulWidget {
  final TextEditingController emailController, firstNameController, lastNameController ;

  const ProfileFormWidget({
    super.key,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
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
              hintText: '${preferenceSettingsProvider.email}',
              controller: widget.emailController,
              prefixIcon: Icon(Icons.alternate_email),
              child: const FormLabelFieldWidget(),
            ),
            AccesorFormFiled(
              hintText: '${preferenceSettingsProvider.firstName}',
              controller: widget.firstNameController,
              prefixIcon: Icon(Icons.person_2_outlined),
              child: const FormLabelFieldWidget(),
            ),
            AccesorFormFiled(
              hintText: '${preferenceSettingsProvider.lastName}',
              controller: widget.lastNameController,
              prefixIcon: Icon(Icons.person_2_outlined),
              child: const FormLabelFieldWidget(),
            ),
          ],
        );
      },
    );
  }
}
