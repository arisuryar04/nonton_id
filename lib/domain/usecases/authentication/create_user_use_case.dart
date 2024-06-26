import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class CreateUserUseCase {
  final AuthenticationRepository _repository;

  CreateUserUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String name,
    required String email,
    required String uid,
    required int balance,
    required DateTime createdAt,
    String? photoUrl,
  }) async {
    return _repository.createUser(
      name: name,
      email: email,
      uid: uid,
      balance: balance,
      createdAt: createdAt,
      photoUrl: photoUrl,
    );
  }
}
