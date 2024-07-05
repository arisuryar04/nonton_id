import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/entities.dart';
import '../../repositories/repository.dart';

class UpdateBalanceUserUseCase {
  final UserRepository _repository;

  UpdateBalanceUserUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String uid,
    required int balance,
  }) async {
    return _repository.updateBalanceUser(uid: uid, balance: balance);
  }
}
