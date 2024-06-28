import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/color.dart';
import '../../core/extension/context_ext.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final Widget? rightChild;
  const AppBarCustom({
    super.key,
    required this.title,
    this.rightChild,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12 + context.paddingAppBar, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: white,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          rightChild ?? const SizedBox(),
        ],
      ),
    );
  }
}
