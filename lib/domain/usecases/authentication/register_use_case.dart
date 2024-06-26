import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class RegisterUseCase {
  final AuthenticationRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String password,
  }) async {
    return _repository.register(email: email, password: password);
  }
}
