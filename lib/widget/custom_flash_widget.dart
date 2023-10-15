import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob_dadah_taufik_p/extensions/context_extensions.dart';

import '../utils/style.dart';

Color? statusColor(status) => status == 'success'
    ? Colors.green[600]
    : status == 'failed'
    ? Colors.red[600]
    : Colors.blue[600];

class CustomFlashWidget extends StatelessWidget {
  final String status;
  final FlashController controller;
  final String title;
  final String message;
  final bool positionBottom;

  const CustomFlashWidget({
    super.key,
    required this.status,
    required this.controller,
    required this.title,
    required this.message,
    required this.positionBottom,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Flash(
      controller: controller,
      position: positionBottom ? FlashPosition.bottom : FlashPosition.top,

      forwardAnimationCurve: Curves.easeInCirc,
      reverseAnimationCurve: Curves.easeOutBack,
      child: DefaultTextStyle(
        style: TextStyle(color: orangeColor),
        child: FlashBar(
          controller: controller,
          title: Text(
            title,
            style: theme.textTheme.headline4!.copyWith(
              color: statusColor(status.toLowerCase()),
              fontSize: 16,
            ),
          ),
          content: Text(
            message,
            style: theme.textTheme.headline4!.copyWith(
              color: statusColor(status.toLowerCase()),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          indicatorColor: statusColor(status.toLowerCase()),
          icon: Icon(
            status.toLowerCase() == 'success'
                ? Icons.check_circle
                : status == 'failed'
                ? Icons.warning_rounded
                : Icons.info,
            color: statusColor(status.toLowerCase()),
          ),
          primaryAction: TextButton(
            onPressed: () => controller.dismiss(),
            child: Text(
              'DISMISS',
              style: theme.textTheme.bodyText1!.copyWith(
                color: statusColor(status.toLowerCase()),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
