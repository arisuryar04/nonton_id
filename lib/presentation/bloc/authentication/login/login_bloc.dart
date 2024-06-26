import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/usecases.dart';
import '../../bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  final LoginUseCase _loginUseCase;
  LoginBloc(
    this._getLoggedUserUseCase,
    this._loginUseCase,
  ) : super(LoginState()) {
    on<OnGetLoggedUser>(_getLoggedUser);
    on<OnLogin>(_login);
  }

  void _login(OnLogin event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: StatusLogin.loading));

    final failureOrUid = await _loginUseCase(
      email: event.email,
      password: event.password,
    );

    failureOrUid.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusLogin.failed,
          message: failure.message,
        ),
      ),
      (uid) => emit(
        state.copyWith(
          status: StatusLogin.success,
          uid: uid,
        ),
      ),
    );
  }

  void _getLoggedUser(OnGetLoggedUser event, Emitter<LoginState> emit) {
    final user = _getLoggedUserUseCase.call;

    if (user != null) {
      emit(state.copyWith(status: StatusLogin.success, uid: user));
    }
  }
}
