part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class OnCreateTransaction extends TransactionEvent {
  final Transaction transaction;

  const OnCreateTransaction(this.transaction);
}

class OnGetTransactionUser extends TransactionEvent {
  final String uid;

  const OnGetTransactionUser(this.uid);
}
