import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/entities.dart';

abstract class TransactionRepository {
  Future<Either<Failure, Transaction>> createTransaction({
    required Transaction transaction,
  });
  Future<Either<Failure, List<Transaction>>> getTransactionUser({
    required String uid,
  });
}
