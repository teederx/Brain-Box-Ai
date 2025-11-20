import 'package:ai_chat_app/core/widgets/custom_loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/chats/chats_provider.dart';
import 'widgets/appbar.dart';
import 'widgets/custom_textfield.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = 'chat';
  static const routeSetting = '/chat';

  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  List<Message> _lastMessages = [];

  void onSend() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      ref.read(chatsProvider.notifier).addMessage(message);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildMessageList(List<Message> messages, {bool isBotTyping = false}) {
    final displayMessages = [
      ...messages,
      if (isBotTyping) Message(role: 'bot_typing', content: ''),
    ];

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      itemCount: displayMessages.length,
      itemBuilder: (context, index) {
        final msg = displayMessages[displayMessages.length - 1 - index];

        if (msg.role == 'bot_typing') {
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomLoadingSpinner(height: 24, width: 24),
            ),
          );
        }

        final isUser = msg.role == 'user';
        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              msg.content,
              style: TextStyle(color: isUser ? Colors.white : Colors.black87),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Message>>>(chatsProvider, (prev, next) {
      next.whenData((messages) {
        _lastMessages = messages; // update only on data
      });
    });

    final chatState = ref.watch(chatsProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Appbar(),

              Expanded(
                child: chatState.when(
                  data: (messages) => buildMessageList(messages),
                  loading:
                      () => buildMessageList(_lastMessages, isBotTyping: true),
                  error: (err, _) => buildMessageList(_lastMessages),
                ),
              ),

              CustomTextfield(onSend: onSend, controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}
