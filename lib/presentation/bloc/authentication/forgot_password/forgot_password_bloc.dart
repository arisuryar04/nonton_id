import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/usecases.dart';
import '../../bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordBloc(this._forgotPasswordUseCase)
      : super(ForgotPasswordState()) {
    on<OnForgotPassword>(_forgotPassword);
  }

  void _forgotPassword(
      OnForgotPassword event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(status: StatusForgotPassword.loading));

    final failureOrMessage = await _forgotPasswordUseCase(email: event.email);

    failureOrMessage.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusForgotPassword.failed,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          status: StatusForgotPassword.success,
          message: message,
        ),
      ),
    );
  }
}
