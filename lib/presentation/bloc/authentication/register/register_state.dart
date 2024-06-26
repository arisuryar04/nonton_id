// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

enum StatusRegister { initial, loading, failed, success }

// ignore: must_be_immutable
class RegisterState extends Equatable {
  StatusRegister? status;
  String? message;

  RegisterState({
    this.status = StatusRegister.initial,
    this.message,
  });

  RegisterState copyWith({
    StatusRegister? status,
    String? message,
  }) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
