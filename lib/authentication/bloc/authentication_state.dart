part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String? token;

  AuthenticationSuccess({this.token});
}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}
