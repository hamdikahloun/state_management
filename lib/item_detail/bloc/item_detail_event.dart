part of 'item_detail_bloc.dart';

abstract class ItemDetailEvent extends Equatable {
  const ItemDetailEvent();

  @override
  List<Object> get props => [];
}

class ItemDetailLoading extends ItemDetailEvent {}

class ItemDetailRequested extends ItemDetailEvent {
  const ItemDetailRequested({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

class ItemDetailFetched extends ItemDetailEvent {}

class ItemDetailError extends ItemDetailEvent {}
