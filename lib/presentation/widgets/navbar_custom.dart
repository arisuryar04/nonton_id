import 'package:flutter/material.dart';

import '../../core/constant/color.dart';
import '../../core/extension/context_ext.dart';
import 'navbar_item.dart';

// ignore: must_be_immutable
class NavbarCustom extends StatelessWidget {
  final List itemNavbar;
  int? selectedItem;
  Function(int index) onTap;

  NavbarCustom({
    super.key,
    required this.itemNavbar,
    this.selectedItem = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(20),
        width: context.fullWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: greyDark,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              itemNavbar.length,
              (index) {
                final item = itemNavbar[index];
                return NavbarItem(
                  isSelected: index == selectedItem,
                  assets:
                      index == selectedItem ? item['selected'] : item['icon'],
                  label: item['title'],
                  onTap: () => onTap.call(index),
                );
              },
            )),
      ),
    );
  }
}
