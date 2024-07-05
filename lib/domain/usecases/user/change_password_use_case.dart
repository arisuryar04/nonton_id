import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class ChangePasswordUseCase {
  final UserRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    return _repository.changePassword(
      newPassword: newPassword,
      email: email,
      oldPassword: oldPassword,
    );
  }
}
