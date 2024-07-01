import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/movie_detail.dart';
import '../../repositories/repository.dart';

class GetMovieDetailUseCase {
  final MovieRepository _repository;

  GetMovieDetailUseCase(this._repository);

  Future<Either<Failure, MovieDetail>> call({required int id}) async {
    return _repository.getMovieDetail(id: id);
  }
}
