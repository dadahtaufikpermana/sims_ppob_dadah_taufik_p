import 'package:flutter/material.dart';
import 'package:inspection/inspection.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';  // Import library untuk NumberFormat

import '../../../utils/access_form_field.dart';
import '../../../utils/provider/prefference_setting_provider.dart';
import '../../../widget/form_label_field_widget.dart';

class NominalWidget extends StatefulWidget {
  final TextEditingController nominalController;

  const NominalWidget({
    Key? key,
    required this.nominalController,
  }) : super(key: key);

  @override
  State<NominalWidget> createState() => _NominalWidgetState();
}

class _NominalWidgetState extends State<NominalWidget> {
  String? _validateNominal(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    final format = NumberFormat.decimalPattern('id');
    final formattedValue = format.parse(value);

    if (formattedValue < 10000) {
      return 'Minimal topup adalah 10.000';
    }

    if (formattedValue > 1000000) {
      return 'Maksimal topup adalah 1.000.000';
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccesorFormFiled(
              prefixText : "Rp. ",
              hintText: 'Masukkan nominal topup',
              controller: widget.nominalController,
              validator: _validateNominal,
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
