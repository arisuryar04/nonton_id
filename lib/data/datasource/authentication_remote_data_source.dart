import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/error/exception.dart';

abstract class AuthenticationRemoteDataSource {
  Future<String> regiter({
    required String email,
    required String password,
  });

  Future<String> createUser({
    required String email,
    required String name,
    required String uid,
    required int balance,
    required DateTime createdAt,
    String? photoUrl,
  });
  Future<String> login({
    required String email,
    required String password,
  });
  Future<String> sendEmailVerification();
  Future<String> forgotPassword({
    required String email,
  });
  Future<void> logout();
  String? get getLoggedUser;
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthenticationRemoteDataSourceImpl(this._firestore, this._firebaseAuth);

  @override
  Future<String> createUser({
    required String email,
    required String name,
    required String uid,
    required int balance,
    required DateTime createdAt,
    String? photoUrl,
  }) async {
    try {
      final docRef = _firestore.collection('user').doc(uid);

      await docRef.set({
        'uid': uid,
        'name': name,
        'email': email,
        'balance': balance,
        'created_at': createdAt.millisecondsSinceEpoch,
        'photo_url': photoUrl,
      });

      final docSnap = await docRef.get();

      if (docSnap.exists) {
        return 'Berhasil, silahkan cek email anda untuk verifikasi';
      } else {
        throw 'Terjadi kesalahan, gagal membuat akun';
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);

    return 'Berhasil, silahkan cek email anda';
  }

  @override
  String? get getLoggedUser {
    final user = _firebaseAuth.currentUser;

    return user?.emailVerified == true ? user?.uid : null;
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user?.emailVerified == true) {
        return credential.user!.uid;
      } else {
        throw NotVerifiedException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'User tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        throw 'Password salah';
      } else {
        throw 'Email atau Password yang anda masukkan salah';
      }
    }
  }

  @override
  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<String> regiter({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.sendEmailVerification();

      if (credential.user != null) {
        return credential.user!.uid;
      } else {
        throw 'Gagal membuat akun';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'Password terlalu lemah';
      } else if (e.code == 'email-already-in-use') {
        throw 'Email telah digunakan';
      } else {
        throw 'Terjadi kesalahan';
      }
    }
  }

  @override
  Future<String> sendEmailVerification() async {
    await _firebaseAuth.currentUser?.sendEmailVerification();

    return 'Kami telah kirimkan email verifikasi';
  }
}
