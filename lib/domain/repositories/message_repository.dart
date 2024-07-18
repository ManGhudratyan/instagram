import '../../data/models/message/message_model.dart';

abstract class MessageRepository {
  Future<void> sendMessage(MessageModel model);
}
