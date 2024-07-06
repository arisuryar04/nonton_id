import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../widgets/widgets.dart';

Widget descriptionSeat() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(3, (index) {
      return Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SelectableCard(
            title: '',
            height: 24,
            width: 24,
            isEnabled: index == 0 ? true : false,
            isSelected: index == 2 ? true : false,
          ),
          Text(
            index == 0
                ? 'Tersedia'
                : index == 1
                    ? 'Tidak Tersedia'
                    : 'Dipilih',
            style: const TextStyle(
              color: grey,
            ),
          ),
        ],
      );
    }),
  );
}
