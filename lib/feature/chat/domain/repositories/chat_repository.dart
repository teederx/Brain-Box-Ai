import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/feature/chat/domain/entities/chat_session.dart';
import 'package:ai_chat_app/feature/chat/domain/entities/message.dart';
import 'package:fpdart/fpdart.dart';

abstract class ChatRepository {
  Stream<List<ChatSession>> getChats();
  Future<Either<Failure, String>> createChat();
  Future<Either<Failure, void>> deleteChat(String chatId);
  Future<Either<Failure, void>> updateChatTitle(String chatId, String newTitle);

  Stream<List<Message>> getMessages(String chatId);
  Future<Either<Failure, void>> sendMessage(String chatId, String content);
}
