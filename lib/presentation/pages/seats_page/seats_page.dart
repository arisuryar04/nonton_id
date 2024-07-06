import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../domain/entities/entities.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

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
            seatSection(
              seats: seats,
              seatsReserved: seatsReserved,
              seatsSelected: seatsSelected,
              onTap: (index) => setState(() {
                if (seatsSelected.contains(seats[index])) {
                  seatsSelected.remove(seats[index]);
                } else {
                  seatsSelected.add(seats[index]);
                }
              }),
            ),
            verticalSpace(48),
            descriptionSeat(),
            verticalSpace(48),
            buttonPay(
              seatsSelected: seatsSelected,
              transaction: widget.transaction,
            ),
          ],
        ),
      ),
    );
  }
}
