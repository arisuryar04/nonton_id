import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/entities.dart';
import '../../repositories/repository.dart';

class GetUserUseCase {
  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<Either<Failure, User>> call({required String uid}) async {
    return _repository.getUser(uid: uid);
  }
}
