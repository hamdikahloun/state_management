import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/login/login.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  void _onLoginButtonPressed() {
    if (_formLoginKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }
  }

  bool isAutovalidate = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final regx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              autovalidateMode: isAutovalidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              key: _formLoginKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Field email is required";
                      }

                      if (!regx.hasMatch(value)) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Field password is required";
                      } else if (value.length < 4) {
                        return "Password must be at least 4 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: state is! LoginInProgress
                        ? () {
                            if (_formLoginKey.currentState?.validate() ==
                                true) {
                              _onLoginButtonPressed();
                            } else {
                              setState(() {
                                isAutovalidate = true;
                              });
                            }
                          }
                        : null,
                    child: const Text('Login'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: state is LoginInProgress
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
