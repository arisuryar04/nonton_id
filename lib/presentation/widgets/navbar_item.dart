import 'package:flutter/material.dart';

import '../../core/constant/color.dart';
import 'widgets.dart';

// ignore: must_be_immutable
class NavbarItem extends StatelessWidget {
  void Function()? onTap;
  String label;
  String assets;
  bool? isSelected;

  NavbarItem({
    super.key,
    required this.onTap,
    required this.label,
    required this.assets,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 14, 24, 8),
        child: Column(
          children: [
            Image.asset(
              assets,
              height: 28,
              width: 28,
            ),
            verticalSpace(5),
            Text(
              label,
              style: TextStyle(color: isSelected == true ? primary : grey),
            ),
          ],
        ),
      ),
    );
  }
}
