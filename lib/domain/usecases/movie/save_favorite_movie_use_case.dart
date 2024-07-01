import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/movie.dart';
import '../../repositories/repository.dart';

class SaveFavoriteMovieUseCase {
  final MovieRepository _repository;

  SaveFavoriteMovieUseCase(this._repository);

  Future<Either<Failure, Movie>> call({required Movie movie}) async {
    return _repository.saveFavoriteMovie(movie: movie);
  }
}
