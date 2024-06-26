import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class SendVerificationEmailUseCase {
  final AuthenticationRepository _repository;

  SendVerificationEmailUseCase(this._repository);

  Future<Either<Failure, String>> call() async {
    return _repository.sendVerificationEmail();
  }
}
