import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class LoginUseCase {
  final AuthenticationRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String password,
  }) async {
    return _repository.login(email: email, password: password);
  }
}
