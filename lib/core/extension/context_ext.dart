import 'package:flutter/material.dart';

import '../../presentation/widgets/widgets.dart';
import '../constant/color.dart';

extension BuildContextExt on BuildContext {
  double get fullHeight => MediaQuery.of(this).size.height;
  double get fullWidth => MediaQuery.of(this).size.width;

  showSnackbar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  showDialogVerification({
    required String title,
    String? content,
    Widget? onConfirm,
    Widget? onCancel,
  }) {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: background,
            title: Text(
              title,
              style: const TextStyle(color: white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content ?? '',
                  style:
                      TextStyle(fontSize: 16, color: white.withOpacity(0.65)),
                ),
                verticalSpace(30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      onConfirm ?? const SizedBox(),
                      horizontalSpace(32),
                      onCancel ?? const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
