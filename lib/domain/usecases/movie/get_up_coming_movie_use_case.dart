import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/movie.dart';
import '../../repositories/repository.dart';

class GetUpComingMovieUseCase {
  final MovieRepository _repository;

  GetUpComingMovieUseCase(this._repository);

  Future<Either<Failure, List<Movie>>> call({int page = 1}) async {
    return _repository.getUpComingMovie(page: page);
  }
}
