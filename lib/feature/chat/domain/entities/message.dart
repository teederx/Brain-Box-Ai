class Message {
  final String id;
  final String content;
  final String role; // 'user' or 'bot'
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.content,
    required this.role,
    required this.createdAt,
  });
}
