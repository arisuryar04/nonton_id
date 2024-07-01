import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/credits.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovie({int page = 1});
  Future<Either<Failure, List<Movie>>> getUpComingMovie({int page = 1});
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int id});
  Future<Either<Failure, List<Credits>>> getCreditsMovie({required int id});
  Future<Either<Failure, List<Movie>>> getFavoriteMovie();
  Future<Either<Failure, Movie>> saveFavoriteMovie({required Movie movie});
  Future<Either<Failure, void>> removeFavoriteMovie({required int id});
}
