import 'package:flutter/material.dart';

import '../../../../core/constant/config.dart';
import '../../../../domain/entities/entities.dart';
import '../../../widgets/widgets.dart';
import 'description_ticket.dart';

Widget fieldTicketMovie(Transaction ticket, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CardNetworkImage(
          '${Config.baseImage}${ticket.transactionImage}',
          height: 120,
          width: 90,
          borderRadius: BorderRadius.circular(5),
        ),
        horizontalSpace(24),
        descriptionTicket(context, ticket),
      ],
    ),
  );
}
