import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_management/authentication/authentication.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final String? token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        authenticationBloc.add(AuthenticationLoggedIn(token: token!));
        yield LoginInitial();
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
