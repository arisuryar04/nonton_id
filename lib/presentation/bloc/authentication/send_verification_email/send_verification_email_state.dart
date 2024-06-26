part of 'send_verification_email_bloc.dart';

enum StatusSendVerification { inital, loading, failed, success }

// ignore: must_be_immutable
class SendVerificationEmailState extends Equatable {
  StatusSendVerification? status;
  String? message;

  SendVerificationEmailState({
    this.status = StatusSendVerification.inital,
    this.message,
  });

  SendVerificationEmailState copyWith({
    StatusSendVerification? status,
    String? message,
  }) {
    return SendVerificationEmailState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
