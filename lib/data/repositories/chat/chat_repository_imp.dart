import '../../../domain/repositories/chat/chat_repository.dart';
import '../../services/chat/chat_service.dart';

class ChatRepositoryImp implements ChatRepository {
  ChatRepositoryImp(this.chatService);

  final ChatService chatService;

  @override
  Stream<List<Map<String, dynamic>>> getMessages(
      String senderId, String receiverId) {
    return chatService.getMessages(senderId, receiverId);
  }

  @override
  Future<void> sendMessage(
      String senderId, String receiverId, String messageText) {
    return chatService.sendMessage(senderId, receiverId, messageText);
  }
}
