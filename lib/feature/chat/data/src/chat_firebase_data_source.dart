import 'package:ai_chat_app/feature/chat/data/models/chat_session_model.dart';
import 'package:ai_chat_app/feature/chat/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/firebase/firebase_constants.dart';

part 'chat_firebase_data_source.g.dart';

class ChatFirebaseDataSource {
  ChatFirebaseDataSource();

  CollectionReference _messagesCollection(String chatId) =>
      chatsCollection.doc(chatId).collection('messages');

  // Chat Sessions
  Stream<List<ChatSessionModel>> getChats() {
    return chatsCollection
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatSessionModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<ChatSessionModel> getChat(String chatId) async {
    final doc = await chatsCollection.doc(chatId).get();
    return ChatSessionModel.fromFirestore(doc);
  }

  Future<void> createChat(ChatSessionModel chat) async {
    await chatsCollection.doc(chat.id).set({
      'title': chat.title,
      'createdAt': Timestamp.fromDate(chat.createdAt),
      'updatedAt': Timestamp.fromDate(chat.updatedAt),
    });
  }

  Future<void> updateChatTitle(String chatId, String newTitle) async {
    await chatsCollection.doc(chatId).update({'title': newTitle});
  }

  Future<void> updateChat(String chatId, Map<String, dynamic> data) async {
    await chatsCollection.doc(chatId).update(data);
  }

  Future<void> deleteChat(String chatId) async {
    await chatsCollection.doc(chatId).delete();
  }

  // Messages
  Stream<List<MessageModel>> getMessages(String chatId) {
    return _messagesCollection(
      chatId,
    ).orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> saveMessage(String chatId, MessageModel message) async {
    await _messagesCollection(chatId).doc(message.id).set({
      'content': message.content,
      'role': message.role,
      'createdAt': Timestamp.fromDate(message.createdAt),
    });
  }
}

@riverpod
ChatFirebaseDataSource chatFirebaseDataSource(Ref ref) {
  return ChatFirebaseDataSource();
}
