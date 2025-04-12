class ChatModel {
  int type;
  String message;
  String senderId;
  int messageType;
  String time;
  bool isRead;

  ChatModel({
    required this.senderId,
    required this.message,
    required this.type,
    required this.time,
    required this.isRead,
    required this.messageType
  });
}