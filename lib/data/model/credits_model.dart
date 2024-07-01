import 'package:equatable/equatable.dart';

import '../../domain/entities/credits.dart';

class CreditsModel extends Equatable {
  final String? name;
  final String? poster;
  final String? status;

  const CreditsModel({
    this.name,
    this.poster,
    this.status,
  });

  factory CreditsModel.fromJson(Map<String, dynamic> map) {
    return CreditsModel(
      name: map['name'] != null ? map['name'] as String : null,
      poster:
          map['profile_path'] != null ? map['profile_path'] as String : null,
      status: map['known_for_department'] != null
          ? map['known_for_department'] as String
          : null,
    );
  }

  Credits toEntity() {
    return Credits(
      name: name,
      poster: poster,
      status: status,
    );
  }

  @override
  List<Object?> get props => [name, poster, status];
}
