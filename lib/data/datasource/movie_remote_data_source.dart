import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constant/config.dart';
import '../../core/error/exception.dart';
import '../model/credits_model.dart';
import '../model/movie_detail_model.dart';
import '../model/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchNowPlayingMovie({int page = 1});
  Future<List<MovieModel>> fetchUpComingMovie({int page = 1});
  Future<MovieDetailModel> fetchMovieDetail({required int id});
  Future<List<CreditsModel>> fetchCreditsMovie({required int id});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<CreditsModel>> fetchCreditsMovie({required int id}) async {
    final response = await _client.get(
      Uri.parse('${Config.baseUrl}/$id/credits'),
      headers: {
        'Authorization': 'Bearer ${Config.token}',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List cast = jsonDecode(response.body)['cast'];
      final List crew = jsonDecode(response.body)['crew'];

      final List rawData = cast..addAll(crew);

      return rawData.map((e) => CreditsModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else {
      throw GeneralException();
    }
  }

  @override
  Future<MovieDetailModel> fetchMovieDetail({required int id}) async {
    final response = await _client.get(
      Uri.parse('${Config.baseUrl}/$id'),
      headers: {
        'Authorization': 'Bearer ${Config.token}',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final rawData = jsonDecode(response.body);

      return MovieDetailModel.fromJson(rawData);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else {
      throw GeneralException();
    }
  }

  @override
  Future<List<MovieModel>> fetchNowPlayingMovie({int page = 1}) async {
    final response = await _client.get(
      Uri.parse('${Config.nowPlaying}&page=$page'),
      headers: {
        'Authorization': 'Bearer ${Config.token}',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List rawData = jsonDecode(response.body)['results'];

      return rawData.map((e) => MovieModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else {
      throw GeneralException();
    }
  }

  @override
  Future<List<MovieModel>> fetchUpComingMovie({int page = 1}) async {
    final response = await _client.get(
      Uri.parse('${Config.upComing}&page=$page'),
      headers: {
        'Authorization': 'Bearer ${Config.token}',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List rawData = jsonDecode(response.body)['results'];

      return rawData.map((e) => MovieModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else {
      throw GeneralException();
    }
  }
}
