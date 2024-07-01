import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/credits.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/repository.dart';
import '../datasource/data_source.dart';
import '../model/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;
  final MovieLocalDataSource _localDataSource;

  MovieRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Either<Failure, List<Credits>>> getCreditsMovie({
    required int id,
  }) async {
    try {
      final model = await _remoteDataSource.fetchCreditsMovie(id: id);

      return Right(model.map((e) => e.toEntity()).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure('Tidak ada data'));
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on GeneralException {
      return const Left(
          GeneralFailure('Terjadi kesalahan, silahkan coba lagi'));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int id}) async {
    try {
      final model = await _remoteDataSource.fetchMovieDetail(id: id);

      return Right(model.toEntity());
    } on NotFoundException {
      return const Left(NotFoundFailure('Tidak ada data'));
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on GeneralException {
      return const Left(
          GeneralFailure('Terjadi kesalahan, silahkan coba lagi'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovie({
    int page = 1,
  }) async {
    try {
      final model = await _remoteDataSource.fetchNowPlayingMovie(page: page);

      return Right(model.map((e) => e.toEntity()).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure('Tidak ada data'));
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on GeneralException {
      return const Left(
          GeneralFailure('Terjadi kesalahan, silahkan coba lagi'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpComingMovie({int page = 1}) async {
    try {
      final model = await _remoteDataSource.fetchUpComingMovie(page: page);

      return Right(model.map((e) => e.toEntity()).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure('Tidak ada data'));
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on GeneralException {
      return const Left(
          GeneralFailure('Terjadi kesalahan, silahkan coba lagi'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavoriteMovie() async {
    try {
      final result = await _localDataSource.fetchFavoriteMovie();

      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Movie>> saveFavoriteMovie({
    required Movie movie,
  }) async {
    try {
      final result = await _localDataSource.saveFavoriteMovie(
        movie: MovieModel.fromEntity(movie),
      );
      return Right(result.toEntity());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteMovie({required int id}) async {
    try {
      return Right(await _localDataSource.removeFavoriteMovie(id: id));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
