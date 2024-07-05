import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/repository.dart';
import '../datasource/data_source.dart';
import '../model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource _remoteDataSource;

  TransactionRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Transaction>> createTransaction({
    required Transaction transaction,
  }) async {
    try {
      final result = await _remoteDataSource.createTransaction(
        transaction: TransactionModel.fromEntity(transaction),
      );
      return Right(result.toEntity());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionUser({
    required String uid,
  }) async {
    try {
      final result = await _remoteDataSource.getTransactionUser(
        uid: uid,
      );
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
