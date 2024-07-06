import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../../core/extension/int_ext.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

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
                backdropMoviePoster(context),
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
                buttonPayNow(transaction: widget.transaction),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
