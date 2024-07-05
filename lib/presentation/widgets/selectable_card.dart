import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class SelectableCard extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final bool? isEnabled;
  final bool? isSelected;
  const SelectableCard({
    super.key,
    required this.title,
    this.onTap,
    this.height = 50,
    this.width = 50,
    this.isEnabled = true,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled == false ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        // margin: const EdgeInsets.only(right: 12),
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected == true
              ? primary.withOpacity(0.9)
              : isEnabled == true
                  ? white.withOpacity(0.75)
                  : grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected == true
                ? white
                : isEnabled == true
                    ? greyDark.withOpacity(0.6)
                    : white.withOpacity(0.4),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
