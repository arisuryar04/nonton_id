import 'package:equatable/equatable.dart';

import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/usecases.dart';
import '../bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransactionUseCase _createTransactionUseCase;
  final GetTransactionUserUseCase _getTransactionUserUseCase;

  TransactionBloc(
    this._createTransactionUseCase,
    this._getTransactionUserUseCase,
  ) : super(TransactionState()) {
    on<OnCreateTransaction>(_createTransaction);
    on<OnGetTransactionUser>(_getTransactionUser);
  }

  void _createTransaction(
    OnCreateTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    emit(state.copyWith(status: StatusTransaction.loading));

    final failureOrTransaction = await _createTransactionUseCase(
      transaction: event.transaction,
    );

    failureOrTransaction.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusTransaction.failed,
          message: failure.message,
        ),
      ),
      (transaction) => emit(
        state.copyWith(
          status: StatusTransaction.success,
          allTransaction: List.of(state.allTransaction ?? [])
            ..add(transaction)
            ..sort(
              (a, b) => b.transactionTime!.compareTo(a.transactionTime!),
            ),
        ),
      ),
    );
  }

  void _getTransactionUser(
    OnGetTransactionUser event,
    Emitter<TransactionState> emit,
  ) async {
    final failureOrTransaction = await _getTransactionUserUseCase(
      uid: event.uid,
    );

    failureOrTransaction.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusTransaction.failed,
          message: failure.message,
        ),
      ),
      (transaction) => emit(
        state.copyWith(
          status: StatusTransaction.success,
          allTransaction: transaction
            ..sort(
              (a, b) => b.transactionTime!.compareTo(a.transactionTime!),
            ),
        ),
      ),
    );
  }
}
