import '../../models/message/message_model.dart';

abstract class MessageService {
  Future<List<MessageModel>> getMessages();
  Future<void> sendMessage(MessageModel messageModel);
}
