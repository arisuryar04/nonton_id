import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class UploadProfilePictureUseCase {
  final UserRepository _repository;

  UploadProfilePictureUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String uid,
    required File image,
  }) async {
    return _repository.uploadProfilePicture(uid: uid, image: image);
  }
}
