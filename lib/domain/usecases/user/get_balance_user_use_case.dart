import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/entities.dart';
import '../../repositories/repository.dart';

class GetBalanceUserUseCase {
  final UserRepository _repository;

  GetBalanceUserUseCase(this._repository);

  Future<Either<Failure, User>> call({required String uid}) async {
    return _repository.getBalanceUser(uid: uid);
  }
}
