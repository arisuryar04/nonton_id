import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repository.dart';
import '../datasource/user_remote_data_source.dart';
import '../model/model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, User>> getBalanceUser({required String uid}) async {
    try {
      final model = await _remoteDataSource.getBalanceUser(uid: uid);
      return Right(model.toEntity());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUser({required String uid}) async {
    try {
      final model = await _remoteDataSource.getUser(uid: uid);
      return Right(model.toEntity());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateBalanceUser({
    required String uid,
    required int balance,
  }) async {
    try {
      final model =
          await _remoteDataSource.updateBalanceUser(uid: uid, balance: balance);
      return Right(model.toEntity());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfileUser({required User user}) async {
    try {
      final model = await _remoteDataSource.updateProfileUser(
          user: UserModel.fromEntity(user));
      return Right(model.toEntity());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture({
    required String uid,
    required File image,
  }) async {
    try {
      final result =
          await _remoteDataSource.uploadProfilePicture(uid: uid, image: image);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    try {
      final result = await _remoteDataSource.changePassword(
        newPassword: newPassword,
        email: email,
        oldPassword: oldPassword,
      );
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
