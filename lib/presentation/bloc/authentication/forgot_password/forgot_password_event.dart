part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class OnForgotPassword extends ForgotPasswordEvent {
  final String email;

  const OnForgotPassword(this.email);
}
