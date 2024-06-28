import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final int? balance;
  final DateTime? createdAt;
  final String? photoUrl;

  const User({
    this.uid,
    this.name,
    this.email,
    this.balance,
    this.createdAt,
    this.photoUrl,
  });

  @override
  List<Object?> get props {
    return [
      uid,
      name,
      email,
      balance,
      createdAt,
      photoUrl,
    ];
  }
}
