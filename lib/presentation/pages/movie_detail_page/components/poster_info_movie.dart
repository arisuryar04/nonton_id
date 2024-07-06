import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/config.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../widgets/widgets.dart';

Widget posterInfoMovie(
  BuildContext context, {
  required String url,
  required List<String> fieldMovie,
  required List<dynamic> fieldValue,
}) {
  return SizedBox(
    height: 160,
    width: context.fullWidth - 32,
    child: Row(
      children: [
        CardNetworkImage(
          '${Config.baseImage}$url',
          height: 160,
          width: 100,
          borderRadius: BorderRadius.circular(5),
        ),
        horizontalSpace(24),
        Wrap(
            runSpacing: 12,
            direction: Axis.vertical,
            spacing: 8,
            children: List.generate(3, (indexRow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (indexColumn) {
                  final key = fieldMovie[indexColumn];
                  final value = fieldValue[indexColumn];

                  return Text(
                    indexRow == 0
                        ? key
                        : indexRow == 1
                            ? ':'
                            : value,
                    style: TextStyle(color: white.withOpacity(0.8)),
                  );
                }).toList(),
              );
            }).toList()),
      ],
    ),
  );
}
