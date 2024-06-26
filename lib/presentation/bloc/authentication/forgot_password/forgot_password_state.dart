// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

enum StatusForgotPassword { initial, loading, failed, success }

// ignore: must_be_immutable
class ForgotPasswordState extends Equatable {
  StatusForgotPassword? status;
  String? message;

  ForgotPasswordState({
    this.status = StatusForgotPassword.initial,
    this.message,
  });

  ForgotPasswordState copyWith({
    StatusForgotPassword? status,
    String? message,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
