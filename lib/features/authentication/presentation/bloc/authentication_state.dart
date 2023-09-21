part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class GoogleSignInSuccessState extends AuthenticationState {
  final GoogleSignInAccount? googleUser;

  GoogleSignInSuccessState(this.googleUser);
}

class GoogleSignOutSuccessState extends AuthenticationState {}

class AuthenticationFailureState extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailureState(this.errorMessage);
}

class AuthenticationLoadingState extends AuthenticationState {
  final String? loading;

  AuthenticationLoadingState({this.loading});
}
