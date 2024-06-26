part of 'send_verification_email_bloc.dart';

sealed class SendVerificationEmailEvent extends Equatable {
  const SendVerificationEmailEvent();

  @override
  List<Object> get props => [];
}

class OnSendVerificationEmail extends SendVerificationEmailEvent {}
