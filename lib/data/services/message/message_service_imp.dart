import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/mixins/chat_mixin.dart';
import '../../models/message/message_model.dart';
import 'message_service.dart';

class MessageServiceImp with MessageMixin implements MessageService {
  MessageServiceImp(this.firebaseDatabase, this.firebaseStorage);
  final FirebaseStorage firebaseStorage;
  @override
  final FirebaseDatabase firebaseDatabase;
  
  @override
  Future<List<MessageModel>> getMessages() async {
    final event = await messageDatabaseReference.once();
    return event.snapshot.children
        .map((e) => MessageModel.fromJson((Map<String, dynamic>.from(
              e.value as Map<dynamic, dynamic>? ?? <String, dynamic>{},
            ))
              ..addAll({'messageId': e.key})))
        .toList();
  }

  @override
  Future<void> sendMessage(MessageModel messageModel) async {
    await messageDatabaseReference.push().set(messageModel.toJson());
  }
  
}
