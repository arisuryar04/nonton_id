import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/credits.dart';
import '../../repositories/repository.dart';

class GetCreditsMovieUseCase {
  final MovieRepository _repository;

  GetCreditsMovieUseCase(this._repository);

  Future<Either<Failure, List<Credits>>> call({required int id}) async {
    return _repository.getCreditsMovie(id: id);
  }
}
