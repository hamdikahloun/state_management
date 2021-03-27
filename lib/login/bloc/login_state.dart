part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  const LoginFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error : $error }';
}
