part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnRegister extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final int balance;
  final DateTime createdAt;
  final String? photoUrl;

  const OnRegister({
    required this.email,
    required this.password,
    required this.name,
    required this.balance,
    required this.createdAt,
    this.photoUrl,
  });
}

class OnCreateUser extends RegisterEvent {
  final String uid;
  final String email;
  final String name;
  final int balance;
  final DateTime createdAt;
  final String? photoUrl;

  const OnCreateUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.balance,
    required this.createdAt,
    this.photoUrl,
  });
}

class OnRegisterFailed extends RegisterEvent {
  final String message;

  const OnRegisterFailed(this.message);
}
