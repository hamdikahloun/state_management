import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/authentication/authentication.dart';
import 'package:state_management/login/login.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              userRepository: userRepository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
