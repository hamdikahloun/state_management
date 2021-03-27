import 'package:blogs_repository/blogs_repository.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.item, required this.onTap})
      : super(key: key);

  final Item item;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.imageUrl),
        backgroundColor: Colors.grey.shade300,
      ),
      title: Text(item.title),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text(item.createdAt),
      dense: true,
    );
  }
}
