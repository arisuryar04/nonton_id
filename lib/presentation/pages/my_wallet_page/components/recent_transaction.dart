import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/assets.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/config.dart';
import '../../../../core/extension/int_ext.dart';
import '../../../../domain/entities/entities.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget recentTransaction() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        const Text(
          'Transaksi terakhir',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        verticalSpace(24),
        BlocSelector<TransactionBloc, TransactionState, List<Transaction>>(
          selector: (state) {
            return state.allTransaction!;
          },
          builder: (context, state) {
            return Column(
              children: state.map((transaction) {
                return Container(
                  height: 120,
                  margin: EdgeInsets.only(
                    bottom: state.last == transaction ? 24 : 12,
                  ),
                  decoration: BoxDecoration(
                    color: black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      transaction.title == 'TOP UP'
                          ? Container(
                              width: 115,
                              height: 145,
                              decoration: const BoxDecoration(
                                color: greyDark,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5)),
                              ),
                              child: Center(
                                child: Image.asset(
                                  Assets.wallet,
                                  color: primary,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            )
                          : CardNetworkImage(
                              '${Config.baseImage}${transaction.transactionImage}',
                              height: 145,
                              width: 115,
                              fit: BoxFit.cover,
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(5)),
                            ),
                      horizontalSpace(24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('HH:mm - EEEE, d MMMM y', 'id')
                                  .format(transaction.transactionTime!),
                              style: const TextStyle(color: grey),
                            ),
                            verticalSpace(8),
                            Text(
                              transaction.title!,
                              style: const TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            verticalSpace(2),
                            Text(
                              '${transaction.title == 'TOP UP' ? '+ ' : ''}${transaction.total!.toCurrency()}',
                              style: TextStyle(
                                color: transaction.title == 'TOP UP'
                                    ? Colors.green
                                    : Colors.amber.shade500,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        )
      ],
    ),
  );
}
