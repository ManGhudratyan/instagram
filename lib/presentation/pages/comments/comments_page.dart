import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/comment_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/comment/comment_repository.dart';
import '../../logic/comment/comment_bloc.dart';
import '../../logic/user/user_bloc.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key, required this.postId, this.userEntity});
  final String postId;
  final UserEntity? userEntity;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUsersCollectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc(RepositoryProvider.of<CommentRepository>(context))
            ..add(ListenCommentsEvent(postId: widget.postId))
            ..add(GetCommentsEvent(postId: widget.postId)),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Comments',
            style: TextStyle(color: Color.fromARGB(255, 137, 123, 123)),
          ),
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
                              ? const Color.fromARGB(255, 129, 129, 129)
                              : Colors.grey,
                          child: ListTile(
                            title: Text(state.comments[index].comment ?? ''),
                            subtitle: Text(
                              state.comments[index].dateTime.toString(),
                            ),
                            trailing: Icon(Icons.favorite_border),
                            leading: Icon(Icons.person_3_rounded),
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
                      color: Color.fromARGB(255, 76, 76, 75).withOpacity(0.5),
                      child: TextField(
                        controller: _commentsController,
                        decoration: InputDecoration(
                          hintText: '   Send',
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<CommentBloc>().add(
                                    SendCommentEvent(
                                      postId: widget.postId,
                                      commentEntity: CommentEntity(
                                        userId: context
                                                .read<UserBloc>()
                                                .state
                                                .userEntity
                                                ?.userId ??
                                            '',
                                        comment: _commentsController.text,
                                        dateTime: Timestamp.now().toDate(),
                                        username: context
                                                .read<UserBloc>()
                                                .state
                                                .userEntity
                                                ?.username ??
                                            '',
                                      ),
                                    ),
                                  );
                              _commentsController.clear();
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
