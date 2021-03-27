import 'package:blogs_repository/blogs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/item_detail/bloc/item_detail_bloc.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({required this.blogRepository, required this.id});

  final String id;
  final BlogRepository blogRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
        'Blog',
      )),
      body: BlocProvider(
        create: (context) => ItemDetailBloc(blogRepository: blogRepository)
          ..add(ItemDetailRequested(id: id)),
        child: BlocBuilder<ItemDetailBloc, ItemDetailState>(
          builder: (context, state) {
            switch (state.status) {
              case DetailItemStatus.failure:
                return const Center(child: Text('failed to fetch item'));
              case DetailItemStatus.success:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(state.item.title,
                          style: Theme.of(context).textTheme.headline6),
                      Text(state.item.createdAt,style: Theme.of(context).textTheme.subtitle1,),
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/loading.gif',
                        image: state.item.imageUrl,
                      ),
                    ],
                  ),
                );
              default:
                return const Center(
                  child: const CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
