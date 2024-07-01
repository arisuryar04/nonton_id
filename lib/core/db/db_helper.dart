import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/model/movie_model.dart';

class DbHelper {
  DbHelper._private();

  static final DbHelper instance = DbHelper._private();

  static Database? _database;

  // Database Nama and Version
  static const String _databaseName = 'nonton-id.db';
  static const int _databaseVersion = 1;

  // Table Favorite Movie
  static const String _tblBookmark = 'favorite';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _posterPath = 'poster_path';
  static const String _backdropPath = 'backdrop_path';
  static const String _voteAverage = 'vote_average';
  static const String _voteCount = 'vote_count';

  /* 
    database => jika database sudah dibuat maka return _database,
    jika belum maka akan _initDatabase() atau membuat database
  */
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /*
    _initDatabase() => Membuat atau create database
  */
  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = join(dir.path, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // CREATE TABLE FAVORITE MOVIE
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $_tblBookmark (
      $_id INTEGER PRIMARY KEY NOT NULL,
      $_title TEXT NOT NULL,
      $_backdropPath TEXT,
      $_posterPath TEXT,
      $_voteAverage REAL,
      $_voteCount INTEGER
      )
      ''',
    );
  }

  // Insert atau Save Favorite Movie
  Future<Map<String, dynamic>> insertMovie(MovieModel movie) async {
    try {
      final db = await database;

      final datas = await db.query(
        _tblBookmark,
        where: '$_id = ?',
        whereArgs: [movie.id],
      );

      if (datas.isNotEmpty) throw 'Movie sudah ada';

      await db.insert(_tblBookmark, movie.toSession());

      return movie.toSession();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteMovie() async {
    final db = await database;

    return await db.query(_tblBookmark);
  }

  Future<void> removeMovie(int id) async {
    final db = await database;

    await db.delete(
      _tblBookmark,
      where: '$_id = ?',
      whereArgs: [id],
    );

    return;
  }
}
