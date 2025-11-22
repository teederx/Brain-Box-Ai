import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../src/chat_firebase_data_source.dart';
import '../../src/chat_gemini_data_source.dart';
import '../chat_repository_impl.dart';

part 'chat_repository_provider.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  final firebaseDataSource = ref.watch(chatFirebaseDataSourceProvider);
  final geminiDataSource = ref.watch(chatGeminiDataSourceProvider);
  return ChatRepositoryImpl(firebaseDataSource, geminiDataSource);
}
