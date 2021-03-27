import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('$transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('$error');
    super.onError(bloc, error, stackTrace);
  }
}
