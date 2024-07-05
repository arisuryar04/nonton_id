import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/entities.dart';
import '../../repositories/repository.dart';

class CreateTransactionUseCase {
  final TransactionRepository _repository;

  CreateTransactionUseCase(this._repository);

  Future<Either<Failure, Transaction>> call({
    required Transaction transaction,
  }) async {
    return _repository.createTransaction(
      transaction: transaction,
    );
  }
}
