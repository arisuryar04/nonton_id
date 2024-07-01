import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class RemoveFavoriteMovieUseCase {
  final MovieRepository _repository;

  RemoveFavoriteMovieUseCase(this._repository);

  Future<Either<Failure, void>> call({required int id}) async {
    return _repository.removeFavoriteMovie(id: id);
  }
}
