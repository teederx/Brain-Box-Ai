import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/feature/chat/data/models/chat_session_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ai_chat_app/feature/chat/data/models/message_model.dart';
import 'package:ai_chat_app/feature/chat/data/src/chat_firebase_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ai_chat_app/feature/chat/data/src/chat_gemini_data_source.dart';
import 'package:ai_chat_app/feature/chat/domain/entities/chat_session.dart';
import 'package:ai_chat_app/feature/chat/domain/entities/message.dart';
import 'package:ai_chat_app/feature/chat/domain/repositories/chat_repository.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatFirebaseDataSource _firebaseDataSource;
  final ChatGeminiDataSource _geminiDataSource;

  ChatRepositoryImpl(this._firebaseDataSource, this._geminiDataSource);

  @override
  Stream<List<ChatSession>> getChats() {
    return _firebaseDataSource.getChats();
  }

  @override
  Future<Either<Failure, String>> createChat() async {
    try {
      final chatId = const Uuid().v4();
      final now = DateTime.now();
      final chat = ChatSessionModel(
        id: chatId,
        title: 'New Chat',
        createdAt: now,
        updatedAt: now,
      );
      await _firebaseDataSource.createChat(chat);
      return Right(chatId);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChat(String chatId) async {
    try {
      await _firebaseDataSource.deleteChat(chatId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateChatTitle(
    String chatId,
    String newTitle,
  ) async {
    try {
      await _firebaseDataSource.updateChatTitle(chatId, newTitle);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<Message>> getMessages(String chatId) {
    return _firebaseDataSource.getMessages(chatId);
  }

  @override
  Future<Either<Failure, void>> sendMessage(
    String chatId,
    String content,
  ) async {
    try {
      // 1. Save User Message
      final userMessage = MessageModel(
        id: const Uuid().v4(),
        content: content,
        role: 'user',
        createdAt: DateTime.now(),
      );
      await _firebaseDataSource.saveMessage(chatId, userMessage);

      // 2. Update Chat History & Generate Title if needed
      final chatSession = await _firebaseDataSource.getChat(chatId);
      final isFirstMessage = chatSession.title == 'New Chat';

      Map<String, dynamic> updates = {
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };

      if (isFirstMessage) {
        final title = await _geminiDataSource.generateTitle(content);
        updates['title'] = title;
      }

      await _firebaseDataSource.updateChat(chatId, updates);

      // 3. Get Response from Gemini
      final botResponseContent = await _geminiDataSource.sendMessage(content);

      // 4. Save Bot Message
      final botMessage = MessageModel(
        id: const Uuid().v4(),
        content: botResponseContent,
        role: 'bot',
        createdAt: DateTime.now(),
      );
      await _firebaseDataSource.saveMessage(chatId, botMessage);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
