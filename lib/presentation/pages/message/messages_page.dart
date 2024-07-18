import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text('Messages'),
          ),
          body: Align(
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
                          onPressed: () {}, icon: const Icon(Icons.send))),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
