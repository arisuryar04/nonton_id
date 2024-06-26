import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class ForgotPasswordUseCase {
  final AuthenticationRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<Either<Failure, String>> call({required String email}) async {
    return _repository.forgotPassword(email: email);
  }
}
