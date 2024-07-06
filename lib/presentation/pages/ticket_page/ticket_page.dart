import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/bloc.dart';
import 'components/components.dart';

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
                      idCardTicket(context, ticket),
                      fieldTicketMovie(ticket, context),
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
