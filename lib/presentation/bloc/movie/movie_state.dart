part of 'movie_bloc.dart';

enum StatusMovie { initial, loading, failed, success }

// ignore: must_be_immutable
class MovieState extends Equatable {
  StatusMovie? status;
  List<Movie>? nowPlaying;
  List<Movie>? upComing;
  List<Movie>? favoriteMovie;
  MovieDetail? movieDetail;
  List<Credits>? actor;
  List<dynamic>? descriptionMovieDetail;
  String? message;

  MovieState({
    this.status = StatusMovie.initial,
    this.nowPlaying,
    this.upComing,
    this.favoriteMovie,
    this.movieDetail,
    this.actor,
    this.descriptionMovieDetail,
    this.message,
  });

  MovieState copyWith({
    StatusMovie? status,
    List<Movie>? nowPlaying,
    List<Movie>? upComing,
    List<Movie>? favoriteMovie,
    MovieDetail? movieDetail,
    List<Credits>? actor,
    List<dynamic>? descriptionMovieDetail,
    String? message,
  }) {
    return MovieState(
      status: status ?? this.status,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      favoriteMovie: favoriteMovie ?? this.favoriteMovie,
      upComing: upComing ?? this.upComing,
      movieDetail: movieDetail ?? this.movieDetail,
      actor: actor ?? this.actor,
      descriptionMovieDetail:
          descriptionMovieDetail ?? this.descriptionMovieDetail,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        nowPlaying,
        upComing,
        movieDetail,
        actor,
        descriptionMovieDetail,
        message,
        favoriteMovie
      ];
}
