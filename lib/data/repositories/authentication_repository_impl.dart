import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../domain/repositories/repository.dart';
import '../datasource/data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, String>> createUser({
    required String name,
    required String email,
    required String uid,
    required int balance,
    required DateTime createdAt,
    String? photoUrl,
  }) async {
    try {
      final result = await _remoteDataSource.createUser(
        email: email,
        name: name,
        uid: uid,
        balance: balance,
        createdAt: createdAt,
        photoUrl: photoUrl,
      );

      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try {
      final result = await _remoteDataSource.forgotPassword(email: email);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  String? get getLoggedUser => _remoteDataSource.getLoggedUser;

  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(result);
    } on NotVerifiedException {
      return const Left(NotVerifiedFailure('Anda belum verifikasi email'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await _remoteDataSource.logout());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.regiter(
        email: email,
        password: password,
      );

      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendVerificationEmail() async {
    try {
      final result = await _remoteDataSource.sendEmailVerification();

      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
