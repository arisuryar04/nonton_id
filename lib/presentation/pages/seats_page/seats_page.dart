import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class SeatsPage extends StatefulWidget {
  final Transaction transaction;

  const SeatsPage({
    super.key,
    required this.transaction,
  });

  @override
  State<SeatsPage> createState() => _SeatsPageState();
}

class _SeatsPageState extends State<SeatsPage> {
  List<String> seats = [];
  List<String> seatsSelected = [];
  List<String> seatsReserved = [];

  @override
  void initState() {
    for (var i = 65; i < 75; i++) {
      for (var j = 1; j <= 10; j++) {
        seats.add('${String.fromCharCode(i)}$j');
      }
    }
    var random = Random();
    // Number of seats to reserve randomly

    for (int i = 0; i <= 30; i++) {
      // Get a random index within the range of seats
      int randomIndex = random.nextInt(seats.length);

      // Check if the seat is already selected or reserved
      if (!seatsSelected.contains(seats[randomIndex]) &&
          !seatsReserved.contains(seats[randomIndex])) {
        // Mark the seat as reserved
        seatsReserved.add(seats[randomIndex]);
      } else {
        i--;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarCustom(
              title: 'Pilih Kursi',
              rightChild: Icon(
                Icons.event_seat,
                color: white,
              ),
            ),
            cinemaScreen(context),
            verticalSpace(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                runSpacing: 16,
                spacing: 5,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: List.generate(
                  100,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index >= 5 && (index - 5) % 10 == 0 ? 16 : 0,
                      ),
                      child: SelectableCard(
                        title: seats[index],
                        height: 31,
                        width: 31,
                        isEnabled: !seatsReserved.contains(seats[index]),
                        isSelected: seatsSelected.contains(seats[index]),
                        onTap: () => setState(() {
                          if (seatsSelected.contains(seats[index])) {
                            seatsSelected.remove(seats[index]);
                          } else {
                            seatsSelected.add(seats[index]);
                          }
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
            verticalSpace(48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SelectableCard(
                      title: '',
                      height: 24,
                      width: 24,
                      isEnabled: index == 0 ? true : false,
                      isSelected: index == 2 ? true : false,
                    ),
                    Text(
                      index == 0
                          ? 'Tersedia'
                          : index == 1
                              ? 'Tidak Tersedia'
                              : 'Dipilih',
                      style: const TextStyle(
                        color: grey,
                      ),
                    ),
                  ],
                );
              }),
            ),
            verticalSpace(48),
            BlocSelector<UserBloc, UserState, String>(
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
                          extra: widget.transaction.copyWith(
                            uid: state,
                            seats: seatsSelected
                              ..sort((a, b) => a.compareTo(b)),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget cinemaScreen(BuildContext context) {
    return Container(
      height: 100,
      width: context.fullWidth,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primary,
            Colors.transparent,
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'Layar Bioskop',
          style: TextStyle(
            color: white,
          ),
        ),
      ),
    );
  }
}
