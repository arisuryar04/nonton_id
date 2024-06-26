import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/usecases.dart';
import '../../bloc.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUseCase _logoutUseCase;

  LogoutBloc(this._logoutUseCase) : super(LogoutState()) {
    on<OnLogout>(_logout);
  }

  void _logout(OnLogout event, Emitter<LogoutState> emit) async {
    emit(state.copyWith(status: StatusLogout.loading));

    final failureOrVoid = await _logoutUseCase();

    await Future.delayed(const Duration(seconds: 5));

    failureOrVoid.fold(
      (failure) => emit(
        state.copyWith(status: StatusLogout.failed, message: failure.message),
      ),
      (_) => emit(
        state.copyWith(status: StatusLogout.success),
      ),
    );
  }
}
