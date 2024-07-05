import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/db/db_helper.dart';
import 'data/datasource/data_source.dart';
import 'data/repositories/repository_impl.dart';
import 'domain/repositories/repository.dart';
import 'domain/usecases/usecases.dart';
import 'presentation/bloc/bloc.dart';

final locator = GetIt.instance;

void injection() {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // Bloc
  locator.registerFactory(() => LoginBloc(locator(), locator()));
  locator.registerFactory(() => LogoutBloc(locator()));
  locator.registerFactory(() => RegisterBloc(locator(), locator()));
  locator.registerFactory(() => ForgotPasswordBloc(locator()));
  locator.registerFactory(() => SendVerificationEmailBloc(locator()));
  locator.registerFactory(
    () => UserBloc(
        locator(), locator(), locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => MovieBloc(locator(), locator(), locator(), locator(), locator(),
        locator(), locator()),
  );
  locator.registerFactory(() => TransactionBloc(locator(), locator()));

  // Usecases
  locator.registerLazySingleton(() => GetLoggedUserUseCase(locator()));
  locator.registerLazySingleton(() => CreateUserUseCase(locator()));
  locator.registerLazySingleton(() => ForgotPasswordUseCase(locator()));
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));
  locator.registerLazySingleton(() => RegisterUseCase(locator()));
  locator.registerLazySingleton(() => SendVerificationEmailUseCase(locator()));
  locator.registerLazySingleton(() => GetBalanceUserUseCase(locator()));
  locator.registerLazySingleton(() => GetUserUseCase(locator()));
  locator.registerLazySingleton(() => UpdateBalanceUserUseCase(locator()));
  locator.registerLazySingleton(() => UpdateProfileUserUseCase(locator()));
  locator.registerLazySingleton(() => UploadProfilePictureUseCase(locator()));
  locator.registerLazySingleton(() => ChangePasswordUseCase(locator()));
  locator.registerLazySingleton(() => GetNowPlayingMovieUseCase(locator()));
  locator.registerLazySingleton(() => GetUpComingMovieUseCase(locator()));
  locator.registerLazySingleton(() => GetCreditsMovieUseCase(locator()));
  locator.registerLazySingleton(() => GetMovieDetailUseCase(locator()));
  locator.registerLazySingleton(() => GetFavoriteMovieUseCase(locator()));
  locator.registerLazySingleton(() => RemoveFavoriteMovieUseCase(locator()));
  locator.registerLazySingleton(() => SaveFavoriteMovieUseCase(locator()));
  locator.registerLazySingleton(() => CreateTransactionUseCase(locator()));
  locator.registerLazySingleton(() => GetTransactionUserUseCase(locator()));

  // Repository
  locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(locator()));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator()));
  locator.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(locator()));

  // Datasource
  locator.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(locator(), locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(locator()));

  // External
  locator.registerLazySingleton(() => firebaseAuth);
  locator.registerLazySingleton(() => firestore);
  locator.registerLazySingleton(() => firebaseStorage);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DbHelper.instance);
}
