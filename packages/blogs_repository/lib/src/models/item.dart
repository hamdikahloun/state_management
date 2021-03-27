import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Item extends Equatable {
  const Item(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.imageUrl});

  final String id;
  final String title;
  final String createdAt;
  final String imageUrl;

  @override
  List<Object> get props => [id, title, createdAt, imageUrl];

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: json['createdAt'] != null
          ? DateFormat('dd-MM-yyyy hh:mm a')
              .format(DateTime.parse(json['createdAt'] as String))
          : '',
      imageUrl: json['imageUrl'] as String,
    );
  }
}
