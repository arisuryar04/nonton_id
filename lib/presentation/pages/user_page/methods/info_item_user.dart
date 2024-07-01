import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';

Widget infoItemUser({required String label, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: white.withOpacity(0.8),
          ),
        ],
      ),
    ),
  );
}
