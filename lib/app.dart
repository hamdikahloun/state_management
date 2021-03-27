import 'package:blogs_repository/blogs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/authentication/authentication.dart';
import 'package:state_management/items/items.dart';
import 'package:state_management/login/login.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: AppView(
        userRepository: userRepository,
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final UserRepository userRepository;

  const AppView({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
            return ItemsPage(
              blogRepository: BlogRepository(token: state.token),
            );
          } else {
            return LoginPage(
              userRepository: userRepository,
            );
          }
        },
      ),
    );
  }
}
