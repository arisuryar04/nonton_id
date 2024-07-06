import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';

Widget searchMovie(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: GestureDetector(
      onTap: () => context.showSnackbar('Belum tersedia'),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: context.fullWidth,
        decoration: BoxDecoration(
          color: greyDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cari Film',
              style: TextStyle(
                color: white.withOpacity(0.7),
              ),
            ),
            Icon(
              Icons.search,
              color: white.withOpacity(0.7),
            ),
          ],
        ),
      ),
    ),
  );
}
