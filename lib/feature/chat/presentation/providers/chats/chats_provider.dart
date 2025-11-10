import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_provider.g.dart';

/// Simple chat message model
class Message {
  final String role; // "user" or "bot"
  final String content;

  Message({required this.role, required this.content});
}

@riverpod
class Chats extends _$Chats {
  @override
  FutureOr<List<Message>> build() {
    return [
      Message(role: 'user', content: 'Hello, how are you?'),
      Message(
        role: 'bot',
        content:
            'Hi there! My name is BrainBox,\nI am doing well, thanks for asking!',
      ),
    ];
  }

  Future<void> addMessage(String userMessage) async {
    final currentMessages = state.value ?? [];

    // 1. Add the user message instantly
    state = AsyncValue.data([
      ...currentMessages,
      Message(role: 'user', content: userMessage),
    ]);

    // 2. Set loading state to indicate "bot is typing"
    state = AsyncValue.loading();

    // 3. Simulate API call to get bot reply
    try {
      await Future.delayed(const Duration(seconds: 3)); // simulate delay
      final botReply = Message(
        role: 'bot',
        content:
            'Hi there! My name is BrainBox,\nI am doing well, thanks for asking!',
      );

      // Append bot reply to last known messages
      state = AsyncValue.data([
        ...currentMessages,
        Message(role: 'user', content: userMessage),
        botReply,
      ]);
    } catch (err, _) {
      // Append error as bot reply
      state = AsyncValue.data([
        ...currentMessages,
        Message(role: 'user', content: userMessage),
        Message(role: 'bot', content: '[Error: $err]'),
      ]);
    }
  }
}
