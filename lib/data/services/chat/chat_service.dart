abstract class ChatService {
  Future<void> sendMessage(
      String senderId, String receiverId, String messageText);
  Stream<List<Map<String, dynamic>>> getMessages(
      String senderId, String receiverId);
}
