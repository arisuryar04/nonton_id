import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/error/exception.dart';
import '../model/model.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionModel> createTransaction({
    required TransactionModel transaction,
  });
  Future<List<TransactionModel>> getTransactionUser({
    required String uid,
  });
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final FirebaseFirestore _firestore;

  TransactionRemoteDataSourceImpl(this._firestore);

  @override
  Future<TransactionModel> createTransaction({
    required TransactionModel transaction,
  }) async {
    try {
      final docRef = _firestore.collection('transaction').doc(transaction.id);

      await docRef.set(transaction.toFirestore());

      final docSnap = await docRef.get();

      if (docSnap.exists) {
        return TransactionModel.fromFirestore(docSnap.data()!);
      } else {
        throw GeneralException();
      }
    } on FirebaseException catch (_) {
      throw GeneralException();
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionUser({
    required String uid,
  }) async {
    try {
      final querySnap = await _firestore
          .collection('transaction')
          .where('uid', isEqualTo: uid)
          .get();

      return querySnap.docs
          .map((e) => TransactionModel.fromFirestore(e.data()))
          .toList();
    } on FirebaseException catch (_) {
      throw GeneralException();
    }
  }
}
