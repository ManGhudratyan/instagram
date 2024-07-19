import '../../domain/repositories/message_repository.dart';
import '../models/message/message_model.dart';
import '../services/message/message_service_imp.dart';

class MessageRepositoryImp implements MessageRepository {
  MessageRepositoryImp(this.messageServiceImp);

  final MessageServiceImp messageServiceImp;
  @override
  Future<void> sendMessage(MessageModel messageModel) {
    return messageServiceImp.sendMessage(messageModel);
  }

  @override
  Future<List<MessageModel>> getMessages() {
    return messageServiceImp.getMessages();
  }
}
