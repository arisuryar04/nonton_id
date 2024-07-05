// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String? id;
  final String? uid;
  final String? title;
  final DateTime? transactionTime;
  final String? transactionImage;
  final List<dynamic>? seats;
  final String? theaterName;
  final DateTime? watchingTime;
  final int? ticketAmount;
  final int? ticketPrice;
  final int? adminFee;
  final int? total;

  const Transaction({
    this.id,
    this.uid,
    this.title,
    this.transactionTime,
    this.transactionImage,
    this.seats,
    this.theaterName,
    this.watchingTime,
    this.ticketAmount,
    this.ticketPrice,
    this.adminFee,
    this.total,
  });

  @override
  List<Object?> get props {
    return [
      id,
      uid,
      title,
      transactionTime,
      transactionImage,
      seats,
      theaterName,
      watchingTime,
      ticketAmount,
      ticketPrice,
      adminFee,
      total,
    ];
  }

  Transaction copyWith({
    String? id,
    String? uid,
    String? title,
    DateTime? transactionTime,
    String? transactionImage,
    List<String>? seats,
    String? theaterName,
    DateTime? watchingTime,
    int? ticketAmount,
    int? ticketPrice,
    int? adminFee,
    int? total,
  }) {
    return Transaction(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      transactionTime: transactionTime ?? this.transactionTime,
      transactionImage: transactionImage ?? this.transactionImage,
      seats: seats ?? this.seats,
      theaterName: theaterName ?? this.theaterName,
      watchingTime: watchingTime ?? this.watchingTime,
      ticketAmount: ticketAmount ?? this.ticketAmount,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      adminFee: adminFee ?? this.adminFee,
      total: total ?? this.total,
    );
  }
}
