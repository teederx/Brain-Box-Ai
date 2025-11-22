import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/provider/chat_repository_provider.dart';

part 'send_message_usecase.g.dart';

class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) {
    return _repository.sendMessage(params.chatId, params.message);
  }
}

class SendMessageParams {
  final String chatId;
  final String message;
  SendMessageParams(this.chatId, this.message);
}

@riverpod
SendMessageUseCase sendMessageUseCase(Ref ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SendMessageUseCase(repository);
}
