import 'package:ai_chat_app/feature/chat/domain/entities/chat_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_session_model.g.dart';

@JsonSerializable()
class ChatSessionModel extends ChatSession {
  const ChatSessionModel({
    required super.id,
    required super.title,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSessionModelToJson(this);

  factory ChatSessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatSessionModel(
      id: doc.id,
      title: data['title'] as String? ?? 'New Chat',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt:
          data['updatedAt'] != null
              ? (data['updatedAt'] as Timestamp).toDate()
              : (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
