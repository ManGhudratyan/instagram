import 'package:firebase_database/firebase_database.dart';

import 'chat_service.dart';

class ChatServiceImp implements ChatService {
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  @override
  Future<void> sendMessage(
      String senderId, String receiverId, String messageText) async {
    final timeSend = DateTime.now().toUtc().toIso8601String();
    final messageRef =
        database.child('users/$senderId/chats/$receiverId/messages').push();
    final message = {
      'text': messageText,
      'senderId': senderId,
      'timeSend': timeSend,
    };
    await messageRef.set(message);

    database
        .child('users/$receiverId/chats/$senderId/messages')
        .push()
        .set(message);
  }

  @override
  Stream<List<Map<String, dynamic>>> getMessages(
      String senderId, String receiverId) {
    return database
        .child('users/$senderId/chats/$receiverId/messages')
        .orderByChild('timeSend')
        .onValue
        .map(
      (event) {
        final snapshot = event.snapshot;
        if (snapshot.value == null) {
          return [];
        }

        final messagesMap = snapshot.value! as Map<Object?, Object?>;
        return messagesMap.entries.map(
          (entry) {
            final value = entry.value! as Map<Object?, Object?>;
            return value.map((key, value) => MapEntry(key.toString(), value));
          },
        ).toList();
      },
    );
  }
}
