import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovieUseCase _nowPlayingMovieUseCase;
  final GetUpComingMovieUseCase _upComingMovieUseCase;
  final GetMovieDetailUseCase _movieDetailUseCase;
  final GetCreditsMovieUseCase _creditsMovieUseCase;
  final GetFavoriteMovieUseCase _getFavoriteMovieUseCase;
  final SaveFavoriteMovieUseCase _saveFavoriteMovieUseCase;
  final RemoveFavoriteMovieUseCase _removeFavoriteMovieUseCase;

  MovieBloc(
    this._nowPlayingMovieUseCase,
    this._upComingMovieUseCase,
    this._movieDetailUseCase,
    this._creditsMovieUseCase,
    this._getFavoriteMovieUseCase,
    this._saveFavoriteMovieUseCase,
    this._removeFavoriteMovieUseCase,
  ) : super(MovieState()) {
    on<OnGetMovie>(_getMovie);
    on<OnGetMovieDetail>(_getMovieDetail);
    on<OnGetMovieDetailSuccess>(_getMovieDetailSuccess);
    on<OnGetMovieSuccess>(_getMovieSuccess);
    on<OnGetMovieFailed>((event, emit) {
      emit(state.copyWith(status: StatusMovie.failed, message: event.message));
    });
    on<OnGetFavoriteMovie>(_getFavoriteMovie);
    on<OnSaveFavorite>(_saveFavoriteMovie);
    on<OnRemoveFavorite>(_removeFavorite);
  }

  void _removeFavorite(
    OnRemoveFavorite event,
    Emitter<MovieState> emit,
  ) async {
    final result = await _removeFavoriteMovieUseCase(id: event.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: StatusMovie.success,
          favoriteMovie: List.of(state.favoriteMovie ?? [])
            ..removeWhere(
              (element) => element.id == event.id,
            ),
        ),
      ),
    );
  }

  void _saveFavoriteMovie(
    OnSaveFavorite event,
    Emitter<MovieState> emit,
  ) async {
    final result = await _saveFavoriteMovieUseCase(
      movie: event.movie,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.message,
        ),
      ),
      (movie) => emit(
        state.copyWith(
          status: StatusMovie.success,
          favoriteMovie: List.of(state.favoriteMovie ?? [])..add(movie),
        ),
      ),
    );
  }

  void _getFavoriteMovie(
    OnGetFavoriteMovie event,
    Emitter<MovieState> emit,
  ) async {
    final result = await _getFavoriteMovieUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.message,
        ),
      ),
      (favorite) => emit(
        state.copyWith(
          status: StatusMovie.success,
          favoriteMovie: favorite,
        ),
      ),
    );
  }

  void _getMovieDetailSuccess(
    OnGetMovieDetailSuccess event,
    Emitter<MovieState> emit,
  ) async {
    final failureOrCredits = await _creditsMovieUseCase(id: event.id);

    failureOrCredits.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusMovie.failed,
          message: failure.message,
        ),
      ),
      (credits) {
        List<Credits> actors = [];
        List<dynamic> description = [];
        for (var actor in credits) {
          if (!actors.contains(actor)) {
            actors.add(actor);
            if (description.length < 4) {
              final director = credits
                  .where((element) => element.status == 'Directing')
                  .toList();
              final writing = credits
                  .where((element) => element.status == 'Writing')
                  .toList();

              description = [
                director.isNotEmpty ? director.first.name : '-',
                writing.isNotEmpty ? writing.first.name : '-',
                event.movieDetail.runtime == 0
                    ? '-'
                    : event.movieDetail.runtime == null
                        ? '-'
                        : '${event.movieDetail.runtime} Menit',
                event.movieDetail.releaseDate != null
                    ? DateFormat('d MMMM y', 'id_ID')
                        .format(event.movieDetail.releaseDate!)
                    : '-',
              ];
            }
          }
        }
        emit(
          state.copyWith(
            status: StatusMovie.success,
            movieDetail: event.movieDetail,
            actor: credits,
            descriptionMovieDetail: description,
          ),
        );
      },
    );
  }

  void _getMovieDetail(
    OnGetMovieDetail event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: StatusMovie.loading));

    final failureOrMovieDetail = await _movieDetailUseCase(id: event.idMovie);

    failureOrMovieDetail.fold(
      (failure) => add(
        OnGetMovieFailed(
          failure.message,
        ),
      ),
      (movieDetail) => add(
        OnGetMovieDetailSuccess(
          movieDetail,
          event.idMovie,
        ),
      ),
    );
  }

  void _getMovieSuccess(
    OnGetMovieSuccess event,
    Emitter<MovieState> emit,
  ) async {
    final failureOrUpComing = await _upComingMovieUseCase();

    failureOrUpComing.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusMovie.failed,
          message: failure.message,
        ),
      ),
      (upComing) => emit(
        state.copyWith(
          status: StatusMovie.success,
          nowPlaying: event.allNowPlaying,
          upComing: upComing,
        ),
      ),
    );
  }

  void _getMovie(OnGetMovie event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: StatusMovie.loading));

    final failureOrNowPlaying = await _nowPlayingMovieUseCase();

    failureOrNowPlaying.fold(
      (failure) => add(OnGetMovieFailed(failure.message)),
      (nowPlaying) => add(
        OnGetMovieSuccess(nowPlaying),
      ),
    );
  }
}
