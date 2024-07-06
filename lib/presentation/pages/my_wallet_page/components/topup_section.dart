import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../core/extension/int_ext.dart';
import '../../../../domain/entities/entities.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget topUpSection(
  BuildContext context, {
  required List<int> nominalTopUp,
  int? selected,
  void Function(int nominal)? onTap,
  void Function()? afterSuccess,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        const Text(
          'Top Up',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: nominalTopUp.map((nominal) {
            return SelectableCard(
              title: nominal.toCurrency(),
              width: (context.fullWidth - 48) / 4.3,
              height: 40,
              isSelected: selected == nominal,
              onTap: () => onTap!.call(nominal),
            );
          }).toList(),
        ),
        verticalSpace(24),
        BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state.status == StatusTransaction.success) {
              afterSuccess!.call();
              context.showSnackbar('Berhasil Top Up Saldo');
            }
            if (state.status == StatusTransaction.failed) {
              context.showSnackbar('Gagal Top Up Saldo');
            }
          },
          builder: (context, state) {
            final user =
                context.select<UserBloc, User>((value) => value.state.user!);
            return ButtonCustom(
              title: 'Top Up',
              width: context.fullWidth / 2,
              onPressed: () {
                if (selected == null) {
                  context.showSnackbar('Nominal belum dipilih');
                } else {
                  context.read<TransactionBloc>().add(
                        OnCreateTransaction(Transaction(
                          id: 'NID-${user.uid}-${DateTime.now().millisecondsSinceEpoch}',
                          transactionImage: 'TOP UP',
                          title: 'TOP UP',
                          transactionTime: DateTime.now(),
                          uid: user.uid,
                          total: selected,
                        )),
                      );
                  context.read<UserBloc>().add(
                      OnUpdateBalanceUser(user.uid!, user.balance! + selected));
                }
              },
            );
          },
        ),
        verticalSpace(16),
        const Divider(color: grey, thickness: 1.2),
      ],
    ),
  );
}
