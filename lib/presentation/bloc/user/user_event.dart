part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnGetUser extends UserEvent {
  final String uid;

  const OnGetUser(this.uid);
}

class OnGetBalanceUser extends UserEvent {
  final String uid;

  const OnGetBalanceUser(this.uid);
}

class OnUpdateBalanceUser extends UserEvent {
  final String uid;
  final int balance;

  const OnUpdateBalanceUser(this.uid, this.balance);
}

class OnUpdateProfileUser extends UserEvent {
  final User user;

  const OnUpdateProfileUser(this.user);
}

class OnUploadProfilePicture extends UserEvent {
  final String uid;
  final String name;
  final File image;

  const OnUploadProfilePicture(this.uid, this.image, this.name);
}

class OnFailedUser extends UserEvent {
  final String message;

  const OnFailedUser(this.message);
}

class OnChangePassword extends UserEvent {
  final String newPassword;
  final String email;
  final String oldPassword;

  const OnChangePassword(this.newPassword, this.email, this.oldPassword);
}
