part of 'item_detail_bloc.dart';

enum DetailItemStatus { initial, success, failure }

class ItemDetailState extends Equatable {
  const ItemDetailState(
      {this.status = DetailItemStatus.initial,
      this.item = const Item(id: '', title: '', createdAt: '', imageUrl: '')});

  final DetailItemStatus status;
  final Item item;

  ItemDetailState copyWith(
      {DetailItemStatus? status, List<Item>? items, Item? item}) {
    return ItemDetailState(
        status: status ?? this.status, item: item ?? this.item);
  }

  @override
  List<Object> get props => [status];
}
