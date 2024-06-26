import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/usecases.dart';
import '../../bloc.dart';

part 'send_verification_email_event.dart';
part 'send_verification_email_state.dart';

class SendVerificationEmailBloc
    extends Bloc<SendVerificationEmailEvent, SendVerificationEmailState> {
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;

  SendVerificationEmailBloc(this._sendVerificationEmailUseCase)
      : super(SendVerificationEmailState()) {
    on<OnSendVerificationEmail>(_sendVerification);
  }

  void _sendVerification(
    OnSendVerificationEmail event,
    Emitter<SendVerificationEmailState> emit,
  ) async {
    emit(state.copyWith(status: StatusSendVerification.loading));

    final failureOrMessage = await _sendVerificationEmailUseCase();

    failureOrMessage.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusSendVerification.failed,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          status: StatusSendVerification.success,
          message: message,
        ),
      ),
    );
  }
}
