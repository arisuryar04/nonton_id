import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../../domain/entities/entities.dart';
import '../../../widgets/widgets.dart';
import 'options_selection_movie_detail.dart';

Widget sectionSchedule(
  BuildContext context,
  MovieDetail movie, {
  required List<String> theaterList,
  String? selectedTheater,
  dynamic Function(String)? onTapTheater,
  required List<DateTime> dateList,
  DateTime? selectedDate,
  dynamic Function(DateTime)? onTapDate,
  required List<int> timeList,
  int? selectedTime,
  dynamic Function(int)? onTapTime,
}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(16),
        OptionSelection(
          title: 'Pilih Theater',
          options: theaterList,
          selected: selectedTheater,
          height: 40,
          width: context.fullWidth / 3.6,
          isScrolable: false,
          onTap: (value) => onTapTheater?.call(value),
        ),
        verticalSpace(24),
        OptionSelection(
          title: 'Pilih Tanggal',
          options: dateList,
          selected: selectedDate,
          height: 50,
          width: 50,
          converter: (date) => DateFormat('d MMM\nEEE', 'id_ID').format(date),
          onTap: (date) => onTapDate?.call(date),
          isEnabled: (date) => selectedTheater == null
              ? false
              : DateTime.now()
                      .isAfter(DateTime(date.year, date.month, date.day + 1))
                  ? false
                  : true,
        ),
        verticalSpace(24),
        OptionSelection(
          title: 'Pilih Jam',
          options: timeList,
          selected: selectedTime,
          isScrolable: false,
          height: 40,
          width: context.fullWidth / 6.5,
          converter: (time) => '$time:00',
          onTap: (time) => onTapTime?.call(time),
          isEnabled: (time) => selectedDate == null
              ? false
              : DateTime.now().isAfter(DateTime(selectedDate.year,
                      selectedDate.month, selectedDate.day, time))
                  ? false
                  : true,
        ),
        verticalSpace(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ButtonCustom(
            title: 'Pilih Kursi',
            onPressed: selectedTheater == null ||
                    selectedDate == null ||
                    selectedTime == null
                ? null
                : () => context.pushNamed(
                      'seats',
                      extra: Transaction(
                        title: movie.title,
                        theaterName: selectedTheater,
                        watchingTime: DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime,
                        ),
                        transactionImage: movie.poster ?? movie.backdrop,
                      ),
                    ),
          ),
        ),
        verticalSpace(24),
      ],
    ),
  );
}
