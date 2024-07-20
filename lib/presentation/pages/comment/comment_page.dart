import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/comment_entity.dart';
import '../../../domain/repositories/comment_repository.dart';
import '../../logic/comment/comment_bloc.dart';
import '../../logic/user/user_bloc.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc(RepositoryProvider.of<CommentRepository>(context))
            ..add(ListenCommentsEvent())
            ..add(GetCommentsEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text(
            'Messages',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Icon(Icons.comment),
          ],
        ),
        body: BlocConsumer<CommentBloc, CommentState>(
          listener: (context, state) {
            if (state is CommentsFailed && state.error != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Positioned.fill(
                  bottom: 100,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ColoredBox(
                          color: state.comments[index].userId ==
                                  context
                                      .read<UserBloc>()
                                      .state
                                      .userEntity
                                      ?.userId
                              ? Colors.green
                              : Colors.grey,
                          child: BlocConsumer<UserBloc, UserState>(
                            listener: (context, userState) {},
                            builder: (context, userState) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      userState.userEntity?.name ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Icon(Icons.favorite_border),
                                    subtitle: Text(
                                        state.comments[index].message ?? ''),
                                    leading: CircleAvatar(
                                      child: CachedNetworkImage(
                                        imageUrl: userState
                                                .userEntity?.profileImage ??
                                            '',
                                      ),
                                    ),
                                  ),
                                  Text(state.comments[index].userId ?? ''),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ColoredBox(
                      color: const Color.fromARGB(255, 127, 127, 127)
                          .withOpacity(0.5),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Write a comment',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<CommentBloc>().add(
                                    SendCommentEvent(
                                      commentEntity: CommentEntity(
                                        userId: context
                                                .read<UserBloc>()
                                                .state
                                                .userEntity
                                                ?.userId ??
                                            '',
                                        message: _messageController.text,
                                      ),
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
