import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/entities.dart';
import '../../repositories/repository.dart';

class UpdateProfileUserUseCase {
  final UserRepository _repository;

  UpdateProfileUserUseCase(this._repository);

  Future<Either<Failure, User>> call({required User user}) async {
    return _repository.updateProfileUser(user: user);
  }
}
