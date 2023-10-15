import 'package:flutter/material.dart';

import '../utils/access_form_field.dart';
import 'form_field_widget.dart';

class FormLabelFieldWidget extends StatelessWidget {

  const FormLabelFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AccesorFormFiled? accessor = AccesorFormFiled.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldWidget(
          hintText: accessor!.hintText,
          controller: accessor.controller,
          obscureText: accessor.obscureText,
          textInputType: accessor.textInputType,
          maxLength: accessor.maxLength,
          validator: accessor.validator,
          textInputAction: accessor.textInputAction,
          showObscureToggle: accessor.showObscureToggle,
          onPressSufixobscureTextIcon: accessor.onPressSufixobscureTextIcon,
          prefixIcon: accessor.prefixIcon,
        ),
      ],
    );
  }
}
