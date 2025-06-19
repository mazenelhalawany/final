class ChatModel {
  final String chatId;
  final String otherUserId;
  final String name;
  final String imageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;

  ChatModel({
    required this.chatId,
    required this.otherUserId,
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}
