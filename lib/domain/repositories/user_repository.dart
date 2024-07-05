import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/entities.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser({required String uid});
  Future<Either<Failure, User>> getBalanceUser({required String uid});
  Future<Either<Failure, User>> updateProfileUser({required User user});
  Future<Either<Failure, User>> updateBalanceUser({
    required String uid,
    required int balance,
  });
  Future<Either<Failure, String>> uploadProfilePicture({
    required String uid,
    required File image,
  });
  Future<Either<Failure, String>> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  });
}
