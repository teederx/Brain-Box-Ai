import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/chat/domain/entities/chat_session.dart';
import 'package:ai_chat_app/feature/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/provider/chat_repository_provider.dart';

part 'chat_usecases.g.dart';

class GetChatsUseCase {
  final ChatRepository _repository;
  GetChatsUseCase(this._repository);
  Stream<List<ChatSession>> call() => _repository.getChats();
}

class CreateChatUseCase implements UseCase<String, NoParams> {
  final ChatRepository _repository;
  CreateChatUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      _repository.createChat();
}

class DeleteChatUseCase implements UseCase<void, String> {
  final ChatRepository _repository;
  DeleteChatUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String chatId) =>
      _repository.deleteChat(chatId);
}

class UpdateChatTitleUseCase implements UseCase<void, UpdateChatTitleParams> {
  final ChatRepository _repository;
  UpdateChatTitleUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(UpdateChatTitleParams params) =>
      _repository.updateChatTitle(params.chatId, params.newTitle);
}

class UpdateChatTitleParams {
  final String chatId;
  final String newTitle;
  UpdateChatTitleParams(this.chatId, this.newTitle);
}

@riverpod
GetChatsUseCase getChatsUseCase(Ref ref) {
  return GetChatsUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
CreateChatUseCase createChatUseCase(Ref ref) {
  return CreateChatUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
DeleteChatUseCase deleteChatUseCase(Ref ref) {
  return DeleteChatUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
UpdateChatTitleUseCase updateChatTitleUseCase(Ref ref) {
  return UpdateChatTitleUseCase(ref.watch(chatRepositoryProvider));
}
