import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'data/datasource/remote_data_source.dart';
import 'data/repositories/repository_impl.dart';
import 'domain/repositories/repository.dart';
import 'domain/usecases/usecases.dart';
import 'presentation/bloc/bloc.dart';

final locator = GetIt.instance;

void injection() {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Bloc
  locator.registerFactory(() => ForgotPasswordBloc(locator()));
  locator.registerFactory(() => LoginBloc(locator(), locator()));
  locator.registerFactory(() => LogoutBloc(locator()));
  locator.registerFactory(() => RegisterBloc(locator(), locator()));
  locator.registerFactory(() => SendVerificationEmailBloc(locator()));

  // Usecases
  locator.registerLazySingleton(() => GetLoggedUserUseCase(locator()));
  locator.registerLazySingleton(() => CreateUserUseCase(locator()));
  locator.registerLazySingleton(() => ForgotPasswordUseCase(locator()));
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));
  locator.registerLazySingleton(() => RegisterUseCase(locator()));
  locator.registerLazySingleton(() => SendVerificationEmailUseCase(locator()));

  // Repository
  locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(locator()));

  // Datasource
  locator.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(locator(), locator()));

  // External
  locator.registerLazySingleton(() => firebaseAuth);
  locator.registerLazySingleton(() => firestore);
}
