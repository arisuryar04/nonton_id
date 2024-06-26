part of 'logout_bloc.dart';

enum StatusLogout { initial, loading, failed, success }

// ignore: must_be_immutable
class LogoutState extends Equatable {
  StatusLogout? status;
  String? message;

  LogoutState({
    this.status = StatusLogout.initial,
    this.message,
  });

  LogoutState copyWith({
    StatusLogout? status,
    String? message,
  }) {
    return LogoutState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
