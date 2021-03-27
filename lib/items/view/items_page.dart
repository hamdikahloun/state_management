import 'package:blogs_repository/blogs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/authentication/authentication.dart';
import 'package:state_management/items/items.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({required this.blogRepository});

  final BlogRepository blogRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLoggedOut());
              },
              child: const Icon(
                Icons.logout,
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) =>
            ItemBloc(blogRepository: blogRepository)..add(ItemFetched()),
        child: ItemsList(
          blogRepository: blogRepository,
        ),
      ),
    );
  }
}
