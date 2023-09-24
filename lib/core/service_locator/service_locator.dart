import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:todorealm/core/google/google_auth_service.dart';
import 'package:todorealm/core/realm/realm_service.dart';
import 'package:todorealm/features/authentication/data/repositories/google_user_repository.dart';
import 'package:todorealm/features/authentication/domain/repositories/google_user_repository.dart';
import 'package:todorealm/features/authentication/domain/usecases/google_auth_use_cases.dart';
import 'package:todorealm/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:todorealm/features/todo/data/datasources/todo_data_source.dart';
import 'package:todorealm/features/todo/data/repositories/todo_repository.dart';
import 'package:todorealm/features/todo/domain/repositories/todo_repository.dart';
import 'package:todorealm/features/todo/domain/usecases/todo_use_cases.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';

final locator = GetIt.instance;

Future<void> initialize() async {
  //================Services
  locator.registerLazySingleton(() => GoogleAuthService());
  final app = App(AppConfiguration(dotenv.env['APPLICATION_ID']!));
  final user = await app.logIn(Credentials.anonymous());

  locator.registerLazySingleton(() => RealmService());

  log('message');

  //=================Remote-Spurces
  locator.registerFactory(() => TodoRemoteSource(locator()));

  //================Repositories
  locator.registerFactory<GoogleUserRepository>(() => GoogleUserRepositoryImpl());
  locator.registerFactory<TodoRepository>(() => TodoRepositoryImpl(locator()));

  //================Use-Cases

  //Authentication Use-Cases
  locator.registerLazySingleton(() => GoogleSignInUseCase(locator()));
  locator.registerLazySingleton(() => GoogleSignOutUseCase(locator()));
  locator.registerLazySingleton(() => RegisterUserUseCase(locator()));

  //Todo Use-Cases
  locator.registerLazySingleton(() => ReadTodoUseCase(locator()));
  locator.registerLazySingleton(() => AddTodoUseCase(locator()));
  locator.registerLazySingleton(() => UpdateTodoUseCase(locator()));
  locator.registerLazySingleton(() => DeleteTodoUseCase(locator()));

  //Blocs
  locator.registerFactory(() => AuthenticationBloc(locator(), locator()));

  locator.registerFactory(() => TodoBloc(locator(), locator(), locator(), locator()));

  log('Initialized Service Locator', name: 'Service Locator');
}
