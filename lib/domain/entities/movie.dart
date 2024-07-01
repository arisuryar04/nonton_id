import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int? id;
  final String? title;
  final String? poster;
  final String? backdrop;
  final double? voteAverage;
  final int? voteCount;

  const Movie({
    this.id,
    this.title,
    this.poster,
    this.backdrop,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      poster,
      backdrop,
      voteAverage,
      voteCount,
    ];
  }
}
