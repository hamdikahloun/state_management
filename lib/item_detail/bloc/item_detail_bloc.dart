import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blogs_repository/blogs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc({required this.blogRepository})
      : super(const ItemDetailState());

  final BlogRepository blogRepository;

  @override
  Stream<Transition<ItemDetailEvent, ItemDetailState>> transformEvents(
    Stream<ItemDetailEvent> events,
    TransitionFunction<ItemDetailEvent, ItemDetailState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ItemDetailState> mapEventToState(
    ItemDetailEvent event,
  ) async* {
    if (event is ItemDetailRequested) {
      yield await _mapitemFetchedToState(event);
    }
  }

  Future<ItemDetailState> _mapitemFetchedToState(
      ItemDetailRequested event) async {
    try {
      final items = await blogRepository.getEntryBlog(id: event.id);
      return state.copyWith(
        status: DetailItemStatus.success,
        item: items,
      );
    } on Exception {
      return state.copyWith(status: DetailItemStatus.failure);
    }
  }
}
