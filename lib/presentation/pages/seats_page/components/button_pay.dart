import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../../domain/entities/transaction.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget buttonPay({
  required List<String> seatsSelected,
  required Transaction transaction,
}) {
  return BlocSelector<UserBloc, UserState, String>(
    selector: (state) {
      return state.user!.uid!;
    },
    builder: (context, state) {
      return ButtonCustom(
        title: 'Bayar',
        width: context.fullWidth - 48,
        onPressed: () {
          if (seatsSelected.isEmpty) {
            context.showSnackbar('Belum ada kursi yang dipilih');
          } else {
            context.pushNamed('order-summary',
                extra: transaction.copyWith(
                  uid: state,
                  seats: seatsSelected..sort((a, b) => a.compareTo(b)),
                  ticketAmount: seatsSelected.length,
                  ticketPrice: 30000,
                  adminFee: 3000,
                  total: (30000 * seatsSelected.length) +
                      (3000 * seatsSelected.length),
                ));
          }
        },
      );
    },
  );
}
