import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blogs_repository/blogs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'item_event.dart';

part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc({required this.blogRepository}) : super(const ItemState());

  final BlogRepository blogRepository;

  @override
  Stream<Transition<ItemEvent, ItemState>> transformEvents(
    Stream<ItemEvent> events,
    TransitionFunction<ItemEvent, ItemState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is ItemFetched) {
      yield await _mapitemFetchedToState(state);
    }
  }

  Future<ItemState> _mapitemFetchedToState(ItemState state) async {
    try {
      final items = await blogRepository.getBlogs();
      return state.copyWith(
        status: ItemStatus.success,
        items: items,
      );
    } on Exception {
      return state.copyWith(status: ItemStatus.failure);
    }
  }
}
