import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/entities.dart';
import '../../repositories/repository.dart';

class GetFavoriteMovieUseCase {
  final MovieRepository _repository;

  GetFavoriteMovieUseCase(this._repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return _repository.getFavoriteMovie();
  }
}
