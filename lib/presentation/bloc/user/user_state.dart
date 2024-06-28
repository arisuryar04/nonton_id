// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

enum StatusUser { initial, loading, failed, success }

// ignore: must_be_immutable
class UserState extends Equatable {
  StatusUser? status;
  User? user;
  String? message;

  UserState({
    this.status = StatusUser.initial,
    this.user,
    this.message,
  });

  UserState copyWith({
    StatusUser? status,
    User? user,
    String? message,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}
