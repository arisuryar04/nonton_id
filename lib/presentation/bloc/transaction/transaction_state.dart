part of 'transaction_bloc.dart';

enum StatusTransaction { initial, loading, failed, success }

// ignore: must_be_immutable
class TransactionState extends Equatable {
  StatusTransaction? status;
  List<Transaction>? allTransaction;
  String? message;

  TransactionState({
    this.status,
    this.allTransaction,
    this.message,
  });

  TransactionState copyWith({
    StatusTransaction? status,
    List<Transaction>? allTransaction,
    String? message,
  }) {
    return TransactionState(
      status: status ?? this.status,
      allTransaction: allTransaction ?? this.allTransaction,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, allTransaction, message];
}
