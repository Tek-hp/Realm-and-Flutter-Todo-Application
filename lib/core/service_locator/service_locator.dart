import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todorealm/core/google/google_auth_service.dart';
import 'package:todorealm/core/realm/realm_service.dart';
import 'package:todorealm/features/authentication/data/repositories/google_user_repository.dart';
import 'package:todorealm/features/authentication/domain/repositories/google_user_repository.dart';
import 'package:todorealm/features/authentication/domain/usecases/google_auth_use_cases.dart';
import 'package:todorealm/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';

final locator = GetIt.instance;

///This function registers the dependencies so that `locator` can provide future referencing through locator.
///It takes a [String] `appId`, which is the application ID of the Realm App Service
Future<void> initialize() async {
  //================Services
  locator.registerLazySingleton(() => GoogleAuthService());
  locator.registerLazySingleton(() => RealmService(locator()));

  //================Use-Cases

  //Authentication Use-Cases
  locator.registerLazySingleton(() => GoogleSignInUseCase(locator()));
  locator.registerLazySingleton(() => GoogleSignOutUseCase(locator()));
  locator.registerLazySingleton(() => RegisterUserUseCase(locator()));

  //================Repositories
  locator.registerFactory<GoogleUserRepository>(() => GoogleUserRepositoryImpl());

  //Blocs
  locator.registerFactory(() => AuthenticationBloc(locator(), locator()));

  locator.registerFactory(() => TodoBloc());

  log('Initialized Service Locator', name: 'Service Locator');
}
