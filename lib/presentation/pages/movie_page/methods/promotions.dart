import 'package:flutter/material.dart';

import '../../../../core/constant/assets.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../widgets/widgets.dart';

Widget promotions(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Promo',
          style: TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(12),
        Container(
          height: 125,
          width: context.fullWidth,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage(Assets.promotions),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            'Dapatkan Diskon 40%\nuntuk Makan & Minum'.toUpperCase(),
            style: const TextStyle(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
