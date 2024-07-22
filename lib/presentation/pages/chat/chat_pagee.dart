import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/chat/chat_bloc.dart';

class ChatPagee extends StatefulWidget {
  const ChatPagee({super.key, required this.uid});
  final String uid;

  @override
  State<ChatPagee> createState() => _ChatPageeState();
}

class _ChatPageeState extends State<ChatPagee> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessagesEvent(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        recipientId: widget.uid));
  }

  void sendMessage(BuildContext context) {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessageEvent(
          senderId: FirebaseAuth.instance.currentUser!.uid,
          recipientId: widget.uid,
          message: message));
      messageController.clear();
      Future.delayed(
        Duration(milliseconds: 300),
        () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  final messagesList = state.messages;

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final messageMap = messagesList[index];
                      final isSender = messageMap['senderId'] ==
                          FirebaseAuth.instance.currentUser!.uid;

                      return Align(
                        alignment: isSender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: isSender ? Colors.blue : Colors.grey,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            messageMap['text'],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('No messages found'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => sendMessage(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
