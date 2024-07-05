import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/entities.dart';
import '../../repositories/repository.dart';

class GetNowPlayingMovieUseCase {
  final MovieRepository _repository;

  GetNowPlayingMovieUseCase(this._repository);

  Future<Either<Failure, List<Movie>>> call({int page = 1}) async {
    return _repository.getNowPlayingMovie(page: page);
  }
}
