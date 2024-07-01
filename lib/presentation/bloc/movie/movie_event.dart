part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovie extends MovieEvent {}

class OnGetMovieSuccess extends MovieEvent {
  final List<Movie> allNowPlaying;
  const OnGetMovieSuccess(
    this.allNowPlaying,
  );
}

class OnGetMovieDetailSuccess extends MovieEvent {
  final MovieDetail movieDetail;
  final int id;
  const OnGetMovieDetailSuccess(
    this.movieDetail,
    this.id,
  );
}

class OnGetMovieFailed extends MovieEvent {
  final String message;
  const OnGetMovieFailed(
    this.message,
  );
}

class OnGetMovieDetail extends MovieEvent {
  final int idMovie;
  final bool isUpComing;

  const OnGetMovieDetail(
    this.idMovie, {
    this.isUpComing = false,
  });
}

class OnSaveFavorite extends MovieEvent {
  final Movie movie;

  const OnSaveFavorite(this.movie);
}

class OnRemoveFavorite extends MovieEvent {
  final int id;

  const OnRemoveFavorite(this.id);
}

class OnGetFavoriteMovie extends MovieEvent {}
