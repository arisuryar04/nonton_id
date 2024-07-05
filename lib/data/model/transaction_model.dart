import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';

class TransactionModel extends Equatable {
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

  const TransactionModel({
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

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'transaction_time': transactionTime?.millisecondsSinceEpoch,
      'transaction_image': transactionImage,
      'seats': seats,
      'theater_name': theaterName,
      'watching_time': watchingTime?.millisecondsSinceEpoch,
      'ticket_amount': ticketAmount,
      'ticket_price': ticketPrice,
      'admin_fee': adminFee,
      'total': total,
    };
  }

  factory TransactionModel.fromFirestore(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] != null ? map['id'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      transactionTime: map['transaction_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['transaction_time'] as int)
          : null,
      transactionImage: map['transaction_image'] != null
          ? map['transaction_image'] as String
          : null,
      seats: map['seats'] != null
          ? List<dynamic>.from((map['seats'] as List<dynamic>))
          : null,
      theaterName:
          map['theater_name'] != null ? map['theater_name'] as String : null,
      watchingTime: map['watching_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['watching_time'] as int)
          : null,
      ticketAmount:
          map['ticket_amount'] != null ? map['ticket_amount'] as int : null,
      ticketPrice:
          map['ticket_price'] != null ? map['ticket_price'] as int : null,
      adminFee: map['admin_fee'] != null ? map['admin_fee'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      uid: uid,
      title: title,
      transactionTime: transactionTime,
      transactionImage: transactionImage,
      seats: seats,
      theaterName: theaterName,
      watchingTime: watchingTime,
      ticketAmount: ticketAmount,
      ticketPrice: ticketPrice,
      adminFee: adminFee,
      total: total,
    );
  }

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      uid: transaction.uid,
      title: transaction.title,
      transactionTime: transaction.transactionTime,
      transactionImage: transaction.transactionImage,
      seats: transaction.seats,
      theaterName: transaction.theaterName,
      watchingTime: transaction.watchingTime,
      ticketAmount: transaction.ticketAmount,
      ticketPrice: transaction.ticketPrice,
      adminFee: transaction.adminFee,
      total: transaction.total,
    );
  }

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
}
