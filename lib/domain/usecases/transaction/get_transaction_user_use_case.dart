import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/transaction.dart';
import '../../repositories/repository.dart';

class GetTransactionUserUseCase {
  final TransactionRepository _repository;

  GetTransactionUserUseCase(this._repository);

  Future<Either<Failure, List<Transaction>>> call({
    required String uid,
  }) async {
    return _repository.getTransactionUser(
      uid: uid,
    );
  }
}
