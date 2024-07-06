import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';

Widget iconFavoriteMovieDetail({
  required bool isSaved,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: isSaved == false
        ? const Icon(
            Icons.favorite_border_rounded,
            color: white,
          )
        : const Icon(
            Icons.favorite_rounded,
            color: primary,
          ),
  );
}
