import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_gemini_data_source.g.dart';

class ChatGeminiDataSource {
  final GenerativeModel _model;
  ChatSession? _chat;

  ChatGeminiDataSource(String apiKey)
    : _model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: apiKey,
        systemInstruction: Content.system(
          'You are BrainBox, a helpful and intelligent AI assistant. '
          'You can write code, answer questions, and help with various tasks. '
          'Format your responses using Markdown, including bold text for emphasis, '
          'tables for structured data, and code blocks for code snippets.',
        ),
      );

  Future<String> sendMessage(String message) async {
    try {
      _chat ??= _model.startChat();
      final response = await _chat!.sendMessage(Content.text(message));
      return response.text ??
          'I am unable to generate a response at the moment.';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<String> generateTitle(String message) async {
    try {
      final prompt =
          'Generate a very short title (max 4 words) for a chat that starts with this message: "$message"';
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? 'New Chat';
    } catch (e) {
      return 'New Chat';
    }
  }
}

@riverpod
ChatGeminiDataSource chatGeminiDataSource(Ref ref) {
  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  if (apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY is missing in .env');
  }
  return ChatGeminiDataSource(apiKey);
}
