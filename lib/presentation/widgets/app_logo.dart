import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(
          color: primary,
          width: 2.5,
        )),
      ),
      child: const Text(
        'NONTON\nID',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: primary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
