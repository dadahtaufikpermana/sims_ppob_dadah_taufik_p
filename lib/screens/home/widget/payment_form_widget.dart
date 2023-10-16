import 'package:flutter/material.dart';
import 'package:inspection/inspection.dart';
import 'package:provider/provider.dart';

import '../../../utils/access_form_field.dart';
import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../widget/form_label_field_widget.dart';

class PaymentFormWidget extends StatefulWidget {
  final TextEditingController paymentController;
  final double? serviceTariff;

  const PaymentFormWidget({
    Key? key,
    required this.paymentController,
    this.serviceTariff,
  }) : super(key: key);

  @override
  State<PaymentFormWidget> createState() => _PaymentFormWidgetState();
}


class _PaymentFormWidgetState extends State<PaymentFormWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccesorFormFiled(
              hintText: widget.serviceTariff != null ? widget.serviceTariff.toString() : '',
              controller: widget.paymentController,
              prefixIcon: Icon(Icons.insert_chart_outlined),
              textInputType: TextInputType.number,
              child: const FormLabelFieldWidget(),
            ),
          ],
        );
      },
    );
  }
}

