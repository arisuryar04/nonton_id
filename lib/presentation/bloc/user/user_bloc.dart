import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase _getUserUseCase;
  final GetBalanceUserUseCase _getBalanceUserUseCase;
  final UploadProfilePictureUseCase _uploadProfilePictureUseCase;
  final UpdateProfileUserUseCase _updateProfileUserUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final UpdateBalanceUserUseCase _updateBalanceUserUseCase;

  UserBloc(
    this._getUserUseCase,
    this._getBalanceUserUseCase,
    this._uploadProfilePictureUseCase,
    this._updateProfileUserUseCase,
    this._changePasswordUseCase,
    this._updateBalanceUserUseCase,
  ) : super(UserState()) {
    on<OnGetUser>(_getUser);
    on<OnGetBalanceUser>(_getBalanceUser);
    on<OnUpdateBalanceUser>(_updateBalanceUser);
    on<OnUploadProfilePicture>(_uploadProfilePicture);
    on<OnUpdateProfileUser>(_updateProfileUser);
    on<OnFailedUser>((event, emit) {
      emit(state.copyWith(message: event.message, status: StatusUser.failed));
    });
    on<OnChangePassword>(_changePassword);
  }

  void _updateBalanceUser(
    OnUpdateBalanceUser event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: StatusUser.loading));

    final failureOrUser = await _updateBalanceUserUseCase(
      uid: event.uid,
      balance: event.balance,
    );

    failureOrUser.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusUser.failed,
          message: failure.message,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: StatusUser.success,
          user: user,
        ),
      ),
    );
  }

  void _changePassword(OnChangePassword event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: StatusUser.loading));

    final failureOrMessage = await _changePasswordUseCase(
      newPassword: event.newPassword,
      email: event.email,
      oldPassword: event.oldPassword,
    );

    failureOrMessage.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusUser.failed,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          status: StatusUser.success,
          message: message,
        ),
      ),
    );
  }

  void _updateProfileUser(OnUpdateProfileUser event, emit) async {
    emit(state.copyWith(status: StatusUser.loading));

    await Future.delayed(const Duration(seconds: 5));

    final failureOrUser = await _updateProfileUserUseCase(user: event.user);

    failureOrUser.fold(
      (failure) => emit(
          state.copyWith(status: StatusUser.failed, message: failure.message)),
      (user) => emit(
        state.copyWith(
          status: StatusUser.success,
          user: user,
        ),
      ),
    );
  }

  void _uploadProfilePicture(
      OnUploadProfilePicture event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: StatusUser.loading));

    final failureOrLink =
        await _uploadProfilePictureUseCase(uid: event.uid, image: event.image);

    failureOrLink.fold(
      (failure) => add(OnFailedUser(failure.message)),
      (link) => add(OnUpdateProfileUser(User(
          photoUrl: link,
          uid: event.uid,
          balance: state.user?.balance,
          createdAt: state.user?.createdAt,
          email: state.user?.email,
          name: event.name))),
    );
  }

  void _getBalanceUser(OnGetBalanceUser event, Emitter<UserState> emit) async {
    final failureOrUser = await _getBalanceUserUseCase(uid: event.uid);

    failureOrUser.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusUser.failed,
          message: failure.message,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: StatusUser.success,
          user: user,
        ),
      ),
    );
  }

  void _getUser(OnGetUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: StatusUser.loading));

    final failureOrUser = await _getUserUseCase(uid: event.uid);

    failureOrUser.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusUser.failed,
          message: failure.message,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: StatusUser.success,
          user: user,
        ),
      ),
    );
  }
}
