import 'package:ai_chat_app/feature/chat/domain/entities/message.dart';
import 'package:ai_chat_app/feature/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/provider/chat_repository_provider.dart';

part 'get_messages_usecase.g.dart';

class GetMessagesUseCase {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);

  Stream<List<Message>> call(String chatId) {
    return _repository.getMessages(chatId);
  }
}

@riverpod
GetMessagesUseCase getMessagesUseCase(Ref ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetMessagesUseCase(repository);
}
