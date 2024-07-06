import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../domain/entities/entities.dart';

Widget idCardTicket(BuildContext context, Transaction ticket) {
  return Container(
    width: context.fullWidth - 32,
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: grey,
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    child: Text(
      ticket.id!,
      style: const TextStyle(
        color: white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
