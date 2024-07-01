import 'package:equatable/equatable.dart';

class Credits extends Equatable {
  final String? name;
  final String? poster;
  final String? status;

  const Credits({
    this.name,
    this.poster,
    this.status,
  });

  @override
  List<Object?> get props => [name, poster, status];
}
