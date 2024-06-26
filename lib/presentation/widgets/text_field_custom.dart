import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

// ignore: must_be_immutable
class TextFieldCustom extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  bool? obscureText;
  TextInputAction? textInputAction;

  TextFieldCustom({
    super.key,
    required this.hint,
    this.controller,
    this.obscureText,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      style: TextStyle(color: white.withOpacity(0.7)),
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        filled: true,
        fillColor: greyDark,
        hintText: widget.hint,
        suffixIcon: widget.obscureText != null
            ? GestureDetector(
                onTap: () => setState(() {
                  widget.obscureText = !widget.obscureText!;
                }),
                child: Icon(widget.obscureText == true
                    ? Icons.visibility_off
                    : Icons.visibility),
              )
            : null,
        hintStyle: const TextStyle(color: grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primary, width: 1),
        ),
      ),
    );
  }
}
