import 'package:equatable/equatable.dart';
import 'package:nonton_id/domain/entities/movie_detail.dart';

class MovieDetailModel extends Equatable {
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

  const MovieDetailModel({
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

  factory MovieDetailModel.fromJson(Map<String, dynamic> map) {
    return MovieDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      poster: map['poster_path'] != null ? map['poster_path'] as String : null,
      backdrop:
          map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
      genres: map['genres'] != null
          ? List<dynamic>.from(
              (map['genres'] as List<dynamic>).map((e) => e['name']).toList())
          : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      releaseDate: map['release_date'] != null
          ? DateTime.parse(map['release_date'] as String)
          : null,
      runtime: map['runtime'] != null ? map['runtime'] as int : null,
      voteAverage:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      voteCount: map['vote_count'] != null ? map['vote_count'] as int : null,
    );
  }

  MovieDetail toEntity() {
    return MovieDetail(
      id: id,
      title: title,
      poster: poster,
      backdrop: backdrop,
      genres: genres,
      overview: overview,
      releaseDate: releaseDate,
      runtime: runtime,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
