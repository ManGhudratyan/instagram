import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../logic/message/message_bloc.dart';
import '../../logic/user/user_bloc.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        if (userState is GetUserDataFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userState.error ?? ''),
            ),
          );
        }
      },
      builder: (context, userState) {
        return BlocProvider(
          create: (context) =>
              MessageBloc(RepositoryProvider.of<MessageRepository>(context))
                ..add(GetMessagesEvent()),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text('Messages'),
            ),
            body: BlocConsumer<MessageBloc, MessageState>(
              listener: (context, messageState) {},
              builder: (context, messageState) {
                return Stack(
                  children: [
                    Positioned.fill(
                      bottom: 100,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: messageState.messages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ColoredBox(
                              color: messageState.messages[index].userId ==
                                      context
                                          .read<UserBloc>()
                                          .state
                                          .userEntity
                                          ?.userId
                                  ? Colors.green
                                  : Colors.grey,
                              child: Column(
                                children: [
                                  Text(messageState.messages[index].message ??
                                      ''),
                                  Text(messageState.messages[index].userId ??
                                      ''),
                                  Text(messageState.messages[index].dateTime
                                      .toString())
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
                            controller: _messageController,
                            decoration: InputDecoration(
                                hintText: 'Send',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      context.read<MessageBloc>().add(
                                            SendMessageEvent(
                                              messageEntity: MessageEntity(
                                                  userId: context
                                                          .read<UserBloc>()
                                                          .state
                                                          .userEntity
                                                          ?.userId ??
                                                      '',
                                                  message:
                                                      _messageController.text,
                                                  dateTime:
                                                      Timestamp.now().toDate()),
                                            ),
                                          );
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
      },
    );
  }
}
