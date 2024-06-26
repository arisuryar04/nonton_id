import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double? width;
  final Color? titleColor;
  final Color? buttonColor;

  const ButtonCustom({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.titleColor = white,
    this.buttonColor = primary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          disabledBackgroundColor: primary.withOpacity(0.3),
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: onPressed == null ? white.withOpacity(0.75) : titleColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
