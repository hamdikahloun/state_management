import 'package:blogs_repository/blogs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/item_detail/item_detail.dart';

import 'package:state_management/items/items.dart';

class ItemsList extends StatelessWidget {
  final BlogRepository blogRepository;

  const ItemsList({Key? key, required this.blogRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void _tapOnBlog(String id) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ItemDetail(
            blogRepository: blogRepository,
            id: id,
          ),
        ),
      );
    }

    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        switch (state.status) {
          case ItemStatus.failure:
            return const Center(child: Text('failed to fetch items'));
          case ItemStatus.success:
            if (state.items.isEmpty) {
              return const Center(child: Text('no items'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListItem(
                  item: state.items[index],
                  onTap: () => _tapOnBlog(state.items[index].id),
                );
              },
              itemCount: state.items.length,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
