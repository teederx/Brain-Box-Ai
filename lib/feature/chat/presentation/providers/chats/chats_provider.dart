import 'dart:developer';
import 'package:ai_chat_app/feature/chat/domain/entities/message.dart';
import 'package:ai_chat_app/feature/chat/domain/usecases/get_messages_usecase.dart';
import 'package:ai_chat_app/feature/chat/domain/usecases/send_message_usecase.dart';
import 'package:ai_chat_app/feature/chat/presentation/providers/active_chat_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_provider.g.dart';

@riverpod
class IsBotTyping extends _$IsBotTyping {
  @override
  bool build() => false;

  void setTyping(bool isTyping) => state = isTyping;
}

@riverpod
class Chats extends _$Chats {
  @override
  Stream<List<Message>> build() {
    final activeChatId = ref.watch(activeChatProvider);
    if (activeChatId == null) {
      return Stream.value([]);
    }
    final getMessages = ref.watch(getMessagesUseCaseProvider);
    return getMessages(activeChatId);
  }

  Future<void> addMessage(String userMessage) async {
    final activeChatId = ref.read(activeChatProvider);
    if (activeChatId == null) return;

    try {
      ref.read(isBotTypingProvider.notifier).setTyping(true);
      final sendMessage = ref.read(sendMessageUseCaseProvider);
      final result = await sendMessage(
        SendMessageParams(activeChatId, userMessage),
      );

      result.fold(
        (failure) => log('Error sending message: ${failure.message}'),
        (_) => null,
      );
    } catch (e) {
      log('Error sending message: $e');
    } finally {
      ref.read(isBotTypingProvider.notifier).setTyping(false);
    }
  }
}
