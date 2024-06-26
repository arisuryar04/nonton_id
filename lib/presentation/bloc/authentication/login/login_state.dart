part of 'login_bloc.dart';

enum StatusLogin { initial, loading, failed, success }

// ignore: must_be_immutable
class LoginState extends Equatable {
  StatusLogin? status;
  String? uid;
  String? message;

  LoginState({
    this.status = StatusLogin.initial,
    this.uid,
    this.message,
  });

  LoginState copyWith({
    StatusLogin? status,
    String? uid,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      uid: uid ?? this.uid,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, uid, message];
}
