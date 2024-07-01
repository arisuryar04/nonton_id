import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

class MovieModel extends Equatable {
  final int? id;
  final String? title;
  final String? poster;
  final String? backdrop;
  final double? voteAverage;
  final int? voteCount;

  const MovieModel({
    this.id,
    this.title,
    this.poster,
    this.backdrop,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      poster: map['poster_path'] != null ? map['poster_path'] as String : null,
      backdrop:
          map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
      voteAverage:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      voteCount: map['vote_count'] != null ? map['vote_count'] as int : null,
    );
  }

  factory MovieModel.fromEntity(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      poster: movie.poster,
      backdrop: movie.backdrop,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
  }

  Map<String, dynamic> toSession() {
    return {
      'id': id,
      'title': title,
      'poster_path': poster,
      'backdrop_path': backdrop,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      poster: poster,
      backdrop: backdrop,
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
      voteAverage,
      voteCount,
    ];
  }
}
