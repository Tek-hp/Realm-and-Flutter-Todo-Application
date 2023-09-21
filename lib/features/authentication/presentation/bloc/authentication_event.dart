part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class GoogleSignInEvent extends AuthenticationEvent {}

class GoogleSignInSuccessEvent extends AuthenticationEvent {}

class GoogleSignOutEvent extends AuthenticationEvent {}

class GoogleSignOutSuccessEvent extends AuthenticationEvent {}
