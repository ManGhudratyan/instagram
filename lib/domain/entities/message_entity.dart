import '../../data/models/message/message_model.dart';

class MessageEntity {
  MessageEntity({this.userId, this.message, this.dateTime, this.messageId});

  factory MessageEntity.fromModel(MessageModel model) => MessageEntity(
        userId: model.userId,
        message: model.message,
        dateTime: model.dateTime,
        messageId: model.messageId,
      );
  final String? userId;
  final String? message;
  final DateTime? dateTime;
  final String? messageId;

  MessageModel toModel() =>
      MessageModel(userId: userId, message: message, dateTime: dateTime);
}
