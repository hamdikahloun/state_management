part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemFetched extends ItemEvent {}
