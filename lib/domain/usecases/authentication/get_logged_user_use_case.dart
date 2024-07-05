import '../../repositories/repository.dart';

class GetLoggedUserUseCase {
  final AuthenticationRepository _repository;

  GetLoggedUserUseCase(this._repository);

  String? get call => _repository.getLoggedUser;
}
