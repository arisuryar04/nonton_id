part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnLogin extends LoginEvent {
  final String email;
  final String password;

  const OnLogin({required this.email, required this.password});
}

class OnGetLoggedUser extends LoginEvent {}
