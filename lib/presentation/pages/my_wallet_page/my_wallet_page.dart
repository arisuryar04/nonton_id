import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nonton_id/core/constant/config.dart';
import 'package:nonton_id/core/extension/context_ext.dart';
import 'package:nonton_id/domain/entities/transaction.dart';
import 'package:nonton_id/presentation/bloc/bloc.dart';

import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../../../core/extension/int_ext.dart';
import '../../../domain/entities/user.dart';
import '../../widgets/widgets.dart';
import 'methods/card_wallet.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  List<int> nominalTopUp = [];
  int? nominalSelected;

  @override
  void initState() {
    for (var i = 1; i <= 12; i++) {
      nominalTopUp.add(i * 50000);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(
              title: 'Dompet Saya',
              rightChild: Image.asset(
                Assets.wallet,
                height: 24,
                width: 24,
              ),
            ),
            cardWallet(),
            verticalSpace(24),
            topUpSection(
              nominalTopUp: nominalTopUp,
              selected: nominalSelected,
              afterSuccess: () => setState(() {
                nominalSelected = null;
              }),
              onTap: (nominal) => setState(() {
                nominalSelected = nominal;
              }),
            ),
            verticalSpace(8),
            recentTransaction(),
          ],
        ),
      ),
    );
  }

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

  Widget topUpSection({
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
                    context.read<UserBloc>().add(OnUpdateBalanceUser(
                        user.uid!, user.balance! + selected));
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
}
