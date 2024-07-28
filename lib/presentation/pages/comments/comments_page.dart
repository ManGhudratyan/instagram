import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/comment/comment_entity.dart';
import '../../../domain/repositories/comment/comment_repository.dart';
import '../../logic/comment/comment_bloc.dart';
import '../../logic/user/user_bloc.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc(RepositoryProvider.of<CommentRepository>(context))
            ..add(ListenCommentsEvent())
            ..add(GetCommentsEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Comments'),
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
                          child: Column(
                            children: [
                              Text(state.comments[index].comment ?? ''),
                              Text(state.comments[index].userId ?? ''),
                              Text(state.comments[index].dateTime.toString())
                            ],
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
                      color: Colors.yellowAccent.withOpacity(0.5),
                      child: TextField(
                        controller: _commentsController,
                        decoration: InputDecoration(
                            hintText: 'Send',
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
                                              comment: _commentsController.text,
                                              dateTime:
                                                  Timestamp.now().toDate()),
                                        ),
                                      );
                                  _commentsController.clear();
                                },
                                icon: const Icon(Icons.send))),
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
