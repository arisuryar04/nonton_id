import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final int? id;
  final String? title;
  final String? poster;
  final String? backdrop;
  final List<dynamic>? genres;
  final String? overview;
  final DateTime? releaseDate;
  final int? runtime;
  final double? voteAverage;
  final int? voteCount;

  const MovieDetail({
    this.id,
    this.title,
    this.poster,
    this.backdrop,
    this.genres,
    this.overview,
    this.releaseDate,
    this.runtime,
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
      genres,
      overview,
      releaseDate,
      runtime,
      voteAverage,
      voteCount,
    ];
  }
}
