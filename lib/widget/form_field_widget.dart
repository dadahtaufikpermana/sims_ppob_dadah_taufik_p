import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';

import '../utils/style.dart';

class FormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool showObscureToggle;
  final int maxLength;
  final int? maxLines;
  final Widget prefixIcon;
  final String? prefixText;

  final VoidCallback? onPressSufixobscureTextIcon;
  final String? Function(String?)? onSubmitted;

  const FormFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.showObscureToggle = false,
    this.maxLength = 30,
    this.maxLines,
    this.onSubmitted,
    this.onPressSufixobscureTextIcon,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.prefixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmitted,
        maxLines: obscureText ? 1 : maxLines,
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 20,
          ),

          prefixIcon: prefixIcon,
          suffixIcon: showObscureToggle
              ? InkWell(
            onTap: onPressSufixobscureTextIcon,
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          )
              : null,
          prefixText: prefixText,
          prefixStyle: TextStyle(
            fontSize: 16,
          ),
          hintStyle: context.theme.textTheme.subtitle1?.copyWith(
            color: grayColor,
          ),
          counter: null,
          counterText: "",
          filled: true,
          isDense: true,
          errorMaxLines: 1,
          errorStyle: context.theme.textTheme.caption?.copyWith(
            color: context.theme.colorScheme.error,
          ),
          fillColor: whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: grayColor20,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: orangeColor,
            ),
          ),
        ),
      ),
    );
  }
}
