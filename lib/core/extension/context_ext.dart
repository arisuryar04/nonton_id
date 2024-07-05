import 'package:flutter/material.dart';

import '../../presentation/widgets/widgets.dart';
import '../constant/color.dart';

extension BuildContextExt on BuildContext {
  double get fullHeight => MediaQuery.of(this).size.height;
  double get fullWidth => MediaQuery.of(this).size.width;
  double get paddingAppBar => MediaQuery.of(this).viewPadding.top;

  showSnackbar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  customDialog({
    required List<Widget> children,
  }) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: greyDark,
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        );
      },
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
