part of 'item_bloc.dart';

enum ItemStatus { initial, success, failure }

class ItemState extends Equatable {
  const ItemState(
      {this.status = ItemStatus.initial, this.items = const <Item>[]});

  final ItemStatus status;
  final List<Item> items;

  ItemState copyWith({ItemStatus? status, List<Item>? items}) {
    return ItemState(
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return '''itemState { status: $status, items: ${items.length} }''';
  }

  @override
  List<Object> get props => [status, items];
}
