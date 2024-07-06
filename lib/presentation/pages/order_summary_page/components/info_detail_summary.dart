import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';

Widget infoDetailSummary({
  required String title,
  String? value,
  List<String>? valueList,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 130,
        child: Text(
          title,
          style: const TextStyle(color: grey, fontSize: 16),
        ),
      ),
      Expanded(
        child: value != null
            ? Text(
                value,
                style: const TextStyle(color: white, fontSize: 16),
              )
            : Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                runSpacing: 4,
                children: valueList!.map((seat) {
                  return Text(
                    '$seat${valueList.last == seat ? '' : ', '}',
                    style: const TextStyle(color: white, fontSize: 16),
                  );
                }).toList(),
              ),
      ),
    ],
  );
}
