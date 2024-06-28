import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser({required String uid});
  Future<UserModel> getBalanceUser({required String uid});
  Future<UserModel> updateBalanceUser({
    required String uid,
    required int balance,
  });
  Future<UserModel> updateProfileUser({required UserModel user});
  Future<String> uploadProfilePicture({
    required String uid,
    required File image,
  });
  Future<String> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _firebaseAuth;

  UserRemoteDataSourceImpl(
    this._firestore,
    this._storage,
    this._firebaseAuth,
  );

  @override
  Future<UserModel> getBalanceUser({required String uid}) async {
    try {
      final docSnap = await _firestore.collection('user').doc(uid).get();
      return UserModel.fromFirestore(docSnap.data()!);
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> getUser({required String uid}) async {
    try {
      final docSnap = await _firestore.collection('user').doc(uid).get();
      return UserModel.fromFirestore(docSnap.data()!);
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> updateBalanceUser({
    required String uid,
    required int balance,
  }) async {
    try {
      final docRef = _firestore.collection('user').doc(uid);

      await docRef.update({
        'balance': balance,
      });

      final user = UserModel.fromFirestore(
          await docRef.get().then((value) => value.data()!));

      if (user.balance == balance) {
        return user;
      } else {
        throw 'Gagal update balance';
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> updateProfileUser({required UserModel user}) async {
    final docRef = _firestore.collection('user').doc(user.uid);

    await docRef.update({
      'uid': user.uid,
      'email': user.email,
      'name': user.name,
      'created_at': user.createdAt?.millisecondsSinceEpoch,
      'balance': user.balance,
      'photo_url': user.photoUrl,
    });

    final docSnap = await docRef.get();

    if (docSnap.exists) {
      return UserModel.fromFirestore(docSnap.data()!);
    } else {
      throw 'Gagal Update Profile';
    }
  }

  @override
  Future<String> uploadProfilePicture({
    required String uid,
    required File image,
  }) async {
    try {
      final storageUser = _storage.ref('user').child(uid);

      await storageUser.putFile(image);

      return await storageUser.getDownloadURL();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      await result.user?.updatePassword(newPassword);
      return 'Berhasil ganti password';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'User tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        throw 'Sandi salah';
      } else {
        throw 'Sandi sebelumnya yang anda masukkan salah';
      }
    }
  }
}
