import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todorealm/features/authentication/domain/usecases/google_auth_use_cases.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
    this._signInUseCase,
    this._signOutUseCase,
  ) : super(AuthenticationInitialState()) {
    on<GoogleSignInEvent>(_googleSignIn);
    on<GoogleSignOutEvent>(_googleSignOut);
  }

  final GoogleSignInUseCase _signInUseCase;
  final GoogleSignOutUseCase _signOutUseCase;

  //Sign in with Google
  Future<void> _googleSignIn(GoogleSignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());

    final response = await _signInUseCase.call(null);
    response.fold(
      (error) {
        AuthenticationFailureState(error);
        log(error);
      },
      (success) {
        log(success.toString());
        emit(
          GoogleSignInSuccessState(success),
        );
      },
    );
  }

  //Sign in From Google
  Future<void> _googleSignOut(GoogleSignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());

    final response = await _signOutUseCase.call(null);

    emit(AuthenticationLoadingState());

    response.fold(
      (failure) => AuthenticationFailureState(failure),
      (success) => GoogleSignOutSuccessState(),
    );
  }
}
