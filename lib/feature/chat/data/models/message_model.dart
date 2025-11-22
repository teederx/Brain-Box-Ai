import 'package:ai_chat_app/feature/chat/domain/entities/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.content,
    required super.role,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      content: data['content'] as String,
      role: data['role'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      content: message.content,
      role: message.role,
      createdAt: message.createdAt,
    );
  }
}
