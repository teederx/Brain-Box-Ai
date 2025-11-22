import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_chat_provider.g.dart';

@riverpod
class ActiveChat extends _$ActiveChat {
  @override
  String? build() {
    return null; // No chat selected initially
  }

  void setActiveChat(String chatId) {
    state = chatId;
  }

  void clear() {
    state = null;
  }
}
