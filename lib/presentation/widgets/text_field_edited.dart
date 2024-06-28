import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class TextFieldEdited extends StatelessWidget {
  final String label;
  final bool? isEnabled;
  final TextEditingController controller;

  const TextFieldEdited({
    super.key,
    required this.label,
    this.isEnabled,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        enabled: isEnabled ?? false,
        style: TextStyle(color: white.withOpacity(0.8)),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          labelStyle: TextStyle(color: white.withOpacity(0.8)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: white.withOpacity(0.6))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: white.withOpacity(0.6))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: white.withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primary)),
        ),
      ),
    );
  }
}
