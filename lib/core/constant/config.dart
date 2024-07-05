class Config {
  static const _token = '';
  static const _baseUrl = 'https://api.themoviedb.org/3/movie';
  static const _nowPlaying = '$_baseUrl/now_playing?region=ID';
  static const _upComing = '$_baseUrl/upcoming?region=ID';
  static const _baseImage = 'https://image.tmdb.org/t/p/w500';

  static String get token => _token;
  static String get baseUrl => _baseUrl;
  static String get nowPlaying => _nowPlaying;
  static String get upComing => _upComing;
  static String get baseImage => _baseImage;
}
