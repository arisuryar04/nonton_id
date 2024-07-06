import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

Widget seatSection({
  required List<String> seats,
  required List<String> seatsReserved,
  required List<String> seatsSelected,
  void Function(int)? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Wrap(
      runSpacing: 16,
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.spaceBetween,
      children: List.generate(
        100,
        (index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index >= 5 && (index - 5) % 10 == 0 ? 16 : 0,
            ),
            child: SelectableCard(
              title: seats[index],
              height: 31,
              width: 31,
              isEnabled: !seatsReserved.contains(seats[index]),
              isSelected: seatsSelected.contains(seats[index]),
              onTap: () => onTap?.call(index),
            ),
          );
        },
      ),
    ),
  );
}
