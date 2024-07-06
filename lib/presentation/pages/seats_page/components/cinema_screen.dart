import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';

Widget cinemaScreen(BuildContext context) {
  return Container(
    height: 100,
    width: context.fullWidth,
    margin: const EdgeInsets.symmetric(horizontal: 24),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          primary,
          Colors.transparent,
        ],
      ),
    ),
    child: const Center(
      child: Text(
        'Layar Bioskop',
        style: TextStyle(
          color: white,
        ),
      ),
    ),
  );
}
