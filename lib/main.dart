import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/app.dart';
import 'package:state_management/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(
    App(
      userRepository: UserRepository(),
    ),
  );
}
