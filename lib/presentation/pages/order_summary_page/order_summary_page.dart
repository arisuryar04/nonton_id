import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nonton_id/core/constant/color.dart';
import 'package:nonton_id/core/constant/config.dart';
import 'package:nonton_id/core/extension/context_ext.dart';
import 'package:nonton_id/core/extension/int_ext.dart';
import 'package:nonton_id/domain/entities/transaction.dart';
import 'package:nonton_id/presentation/widgets/widgets.dart';

import '../../../domain/entities/user.dart';
import '../../bloc/bloc.dart';

class OrderSummaryPage extends StatefulWidget {
  final Transaction transaction;

  const OrderSummaryPage({
    super.key,
    required this.transaction,
  });

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(OnGetBalanceUser(widget.transaction.uid!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const AppBarCustom(
            title: 'Detail Pesanan',
            rightChild: SizedBox(width: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backdropMoviePoster(),
                verticalSpace(24),
                Text(
                  widget.transaction.title!,
                  style: const TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(color: grey, thickness: 2),
                verticalSpace(8),
                SizedBox(
                  width: context.fullWidth,
                  child: Column(
                    children: [
                      infoDetailSummary(
                        title: 'Tanggal',
                        value: DateFormat('EEEE, d MMMM y - HH:mm', 'id')
                            .format(widget.transaction.watchingTime!),
                      ),
                      verticalSpace(8),
                      infoDetailSummary(
                        title: 'Theater',
                        value: widget.transaction.theaterName,
                      ),
                      verticalSpace(8),
                      infoDetailSummary(
                        title: 'No Kursi',
                        valueList: widget.transaction.seats as List<String>,
                      ),
                      verticalSpace(8),
                      infoDetailSummary(
                        title: 'Jumlah Tiket',
                        value: '${widget.transaction.ticketAmount} Tiket',
                      ),
                      verticalSpace(8),
                      infoDetailSummary(
                        title: 'Harga Tiket',
                        value: widget.transaction.ticketPrice?.toCurrency(),
                      ),
                      verticalSpace(8),
                      infoDetailSummary(
                        title: 'Biaya Admin',
                        value: widget.transaction.adminFee?.toCurrency(),
                      ),
                    ],
                  ),
                ),
                verticalSpace(8),
                const Divider(color: grey, thickness: 2),
                verticalSpace(8),
                infoDetailSummary(
                  title: 'Total',
                  value: widget.transaction.total?.toCurrency(),
                ),
                verticalSpace(72),
                BlocConsumer<TransactionBloc, TransactionState>(
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
                            onPressed: () =>
                                context.pushReplacementNamed('home'),
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
                    final user = context
                        .select<UserBloc, User>((value) => value.state.user!);
                    return ButtonCustom(
                      title: 'Bayar Sekarang',
                      onPressed: () {
                        if (user.balance! - widget.transaction.total! >= 0) {
                          context
                              .read<TransactionBloc>()
                              .add(OnCreateTransaction(
                                widget.transaction.copyWith(
                                  id: 'NID-${user.uid}-${DateTime.now().millisecondsSinceEpoch}',
                                  transactionTime: DateTime.now(),
                                ),
                              ));
                          context.read<UserBloc>().add(
                                OnUpdateBalanceUser(user.uid!,
                                    user.balance! - widget.transaction.total!),
                              );
                        } else {
                          context.showSnackbar(
                              'Saldo anda tidak mencukupi untuk memesan tiket');
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoDetailSummary({
    required String title,
    String? value,
    List<String>? valueList,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            title,
            style: const TextStyle(color: grey, fontSize: 16),
          ),
        ),
        Expanded(
          child: value != null
              ? Text(
                  value,
                  style: const TextStyle(color: white, fontSize: 16),
                )
              : Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 4,
                  children: valueList!.map((seat) {
                    return Text(
                      '$seat${valueList.last == seat ? '' : ', '}',
                      style: const TextStyle(color: white, fontSize: 16),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Widget backdropMoviePoster() {
    return BlocSelector<MovieBloc, MovieState, String>(
      selector: (state) {
        return state.movieDetail?.backdrop ?? state.movieDetail!.poster!;
      },
      builder: (context, state) {
        return CardNetworkImage(
          '${Config.baseImage}$state',
          height: context.fullWidth * 0.5,
          width: context.fullWidth,
          borderRadius: BorderRadius.circular(8),
        );
      },
    );
  }
}
