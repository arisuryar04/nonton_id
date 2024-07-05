import '../../core/db/db_helper.dart';
import '../model/model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> fetchFavoriteMovie();
  Future<MovieModel> saveFavoriteMovie({required MovieModel movie});
  Future<void> removeFavoriteMovie({required int id});
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DbHelper _dbHelper;

  MovieLocalDataSourceImpl(this._dbHelper);

  @override
  Future<List<MovieModel>> fetchFavoriteMovie() async {
    final result = await _dbHelper.getFavoriteMovie();

    return result.map((e) => MovieModel.fromJson(e)).toList();
  }

  @override
  Future<void> removeFavoriteMovie({required int id}) async {
    try {
      return await _dbHelper.removeMovie(id);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<MovieModel> saveFavoriteMovie({required MovieModel movie}) async {
    try {
      final result = await _dbHelper.insertMovie(movie);

      return MovieModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }
}
