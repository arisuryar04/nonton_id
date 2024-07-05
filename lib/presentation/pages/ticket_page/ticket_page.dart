import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/config.dart';
import '../../../core/extension/context_ext.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TransactionBloc, TransactionState, List<Transaction>>(
      selector: (state) {
        return state.allTransaction!;
      },
      builder: (context, state) {
        final tickets =
            state.where((element) => element.title != 'TOP UP').toList();
        if (tickets.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada ticket nih',
              style: TextStyle(
                color: white,
                fontSize: 16,
              ),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(
            top: context.paddingAppBar + 12,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: tickets.map((ticket) {
                return Container(
                  width: context.fullWidth,
                  margin: EdgeInsets.only(
                    bottom: tickets.last == ticket ? 110 : 12,
                  ),
                  decoration: BoxDecoration(
                    color: greyDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: context.fullWidth - 32,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: grey,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        child: Text(
                          ticket.id!,
                          style: const TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
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
                            SizedBox(
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
                                    DateFormat('EEEE, d MMMM y | HH:mm')
                                        .format(ticket.watchingTime!),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
