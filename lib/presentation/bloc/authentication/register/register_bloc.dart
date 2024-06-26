import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/usecases.dart';
import '../../bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final CreateUserUseCase _createUserUseCase;

  RegisterBloc(
    this._registerUseCase,
    this._createUserUseCase,
  ) : super(RegisterState()) {
    on<OnRegister>(_register);
    on<OnCreateUser>(_createUser);
    on<OnRegisterFailed>(_registerFailed);
  }

  void _registerFailed(OnRegisterFailed event, Emitter<RegisterState> emit) {
    emit(state.copyWith(status: StatusRegister.failed, message: event.message));
  }

  void _createUser(OnCreateUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: StatusRegister.loading));

    await Future.delayed(const Duration(seconds: 5));

    final failureOrMessage = await _createUserUseCase(
      uid: event.uid,
      name: event.name,
      email: event.email,
      balance: event.balance,
      createdAt: event.createdAt,
      photoUrl: event.photoUrl,
    );

    failureOrMessage.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusRegister.failed,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          status: StatusRegister.success,
          message: message,
        ),
      ),
    );
  }

  void _register(OnRegister event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: StatusRegister.loading));

    final failureOrUid = await _registerUseCase(
      email: event.email,
      password: event.password,
    );

    failureOrUid.fold(
      (failure) => add(OnRegisterFailed(failure.message)),
      (uid) => add(OnCreateUser(
        uid: uid,
        name: event.name,
        email: event.email,
        balance: event.balance,
        createdAt: event.createdAt,
        photoUrl: event.photoUrl,
      )),
    );
  }
}
