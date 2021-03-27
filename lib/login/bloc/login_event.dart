part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    required this.username,
    required this.password,
  });

  final String username, password;

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username : $username, password : $password }';
}
