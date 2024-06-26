import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

class NotVerifiedFailure extends Failure {
  const NotVerifiedFailure(super.message);
}
