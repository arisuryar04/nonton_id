import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../widgets/widgets.dart';

// ignore: must_be_immutable
class OptionSelection<T> extends StatelessWidget {
  T? selected;
  List<T>? options;
  bool Function(T object)? isEnabled;
  String Function(T object)? converter;
  double? height;
  double? width;
  Function(T object)? onTap;
  bool? isScrolable = false;
  String title;

  OptionSelection({
    super.key,
    this.selected,
    this.options,
    this.isEnabled,
    this.converter,
    this.height,
    this.width,
    this.onTap,
    this.isScrolable,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
          verticalSpace(12),
          isScrolable == false
              ? Wrap(
                  runSpacing: 8,
                  spacing: 12,
                  children: options!.map((e) {
                    return SelectableCard(
                      isEnabled: isEnabled != null ? isEnabled!(e) : true,
                      title: converter != null ? converter!.call(e) : '$e',
                      height: height,
                      width: width,
                      isSelected: selected == e,
                      onTap: () => onTap?.call(e),
                    );
                  }).toList(),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: options!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SelectableCard(
                          isEnabled: isEnabled != null ? isEnabled!(e) : true,
                          title: converter != null ? converter!.call(e) : '$e',
                          height: height,
                          width: width,
                          isSelected: selected == e,
                          onTap: () => onTap?.call(e),
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
