import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../domain/entities/entities.dart';
import '../../../widgets/widgets.dart';

Widget descriptionTicket(BuildContext context, Transaction ticket) {
  return SizedBox(
    width: context.fullWidth / 1.75,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ticket.title!,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(8),
        Text(
          ticket.theaterName!,
          style: const TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          DateFormat('EEEE, d MMMM y | HH:mm').format(ticket.watchingTime!),
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(8),
        Text(
          '${ticket.ticketAmount} Ticket',
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(2),
        Wrap(
          runSpacing: 5,
          children: ticket.seats!.map((seat) {
            return Text(
              '$seat${ticket.seats?.last == seat ? '' : ', '}',
              style: const TextStyle(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
