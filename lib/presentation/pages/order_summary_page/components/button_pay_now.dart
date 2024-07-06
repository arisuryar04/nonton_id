import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../domain/entities/entities.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget buttonPayNow({
  required Transaction transaction,
}) {
  return BlocConsumer<TransactionBloc, TransactionState>(
    listener: (context, state) {
      if (state.status == StatusTransaction.loading) {
        context.customDialog(
          children: [
            const CircularProgressIndicator(),
          ],
        );
      }
      if (state.status == StatusTransaction.success) {
        context.pop();
        context.customDialog(
          children: [
            const Text(
              'Berhasil',
              style: TextStyle(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(24),
            const Icon(
              Icons.verified_rounded,
              size: 80,
              color: primary,
            ),
            verticalSpace(16),
            TextButton(
              onPressed: () => context.pushReplacementNamed('home'),
              child: const Text(
                'Kembali ke Home',
                style: TextStyle(color: primary, fontSize: 16),
              ),
            ),
          ],
        );
      }
      if (state.status == StatusTransaction.failed) {
        context.pop();
        context.customDialog(
          children: [
            const Text(
              'Gagal',
              style: TextStyle(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(24),
            const Icon(
              Icons.cancel,
              size: 80,
              color: Colors.red,
            ),
            verticalSpace(16),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'Kembali',
                style: TextStyle(color: white, fontSize: 16),
              ),
            ),
          ],
        );
      }
    },
    builder: (context, state) {
      final user = context.select<UserBloc, User>((value) => value.state.user!);
      return ButtonCustom(
        title: 'Bayar Sekarang',
        onPressed: () {
          if (user.balance! - transaction.total! >= 0) {
            context.read<TransactionBloc>().add(OnCreateTransaction(
                  transaction.copyWith(
                    id: 'NID-${user.uid}-${DateTime.now().millisecondsSinceEpoch}',
                    transactionTime: DateTime.now(),
                  ),
                ));
            context.read<UserBloc>().add(
                  OnUpdateBalanceUser(
                      user.uid!, user.balance! - transaction.total!),
                );
          } else {
            context
                .showSnackbar('Saldo anda tidak mencukupi untuk memesan tiket');
          }
        },
      );
    },
  );
}
