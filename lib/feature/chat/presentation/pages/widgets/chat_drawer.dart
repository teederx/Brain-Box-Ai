import 'package:ai_chat_app/feature/chat/domain/entities/chat_session.dart';
import 'package:ai_chat_app/feature/chat/domain/usecases/chat_usecases.dart';
import 'package:ai_chat_app/feature/chat/presentation/providers/active_chat_provider.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatDrawer extends ConsumerWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsAsync = ref.watch(getChatsUseCaseProvider).call();
    final activeChatId = ref.watch(activeChatProvider);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                'Chat History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('New Chat'),
            onTap: () async {
              final createChat = ref.read(createChatUseCaseProvider);
              final result = await createChat(NoParams());

              result.fold(
                (failure) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error creating chat: ${failure.message}'),
                  ),
                ),
                (newChatId) {
                  ref
                      .read(activeChatProvider.notifier)
                      .setActiveChat(newChatId);
                  if (context.mounted) {
                    context.pop(); // Close drawer
                  }
                },
              );
            },
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<List<ChatSession>>(
              stream: chatsAsync,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final chats = snapshot.data!;
                if (chats.isEmpty) {
                  return const Center(child: Text('No chat history'));
                }

                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final isActive = chat.id == activeChatId;

                    return ListTile(
                      selected: isActive,
                      selectedTileColor: Colors.grey.withValues(alpha: 0.1),
                      title: Text(
                        _cleanTitle(chat.title),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        ref
                            .read(activeChatProvider.notifier)
                            .setActiveChat(chat.id);
                        context.pop(); // Close drawer
                      },
                      onLongPress: () {
                        _showEditDeleteDialog(context, ref, chat);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    ChatSession chat,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chat Options'),
          content: Text('What do you want to do with "${chat.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                _showRenameDialog(context, ref, chat);
              },
              child: const Text('Rename'),
            ),
            TextButton(
              onPressed: () async {
                final deleteChat = ref.read(deleteChatUseCaseProvider);
                final result = await deleteChat(chat.id);

                result.fold(
                  (failure) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting chat: ${failure.message}'),
                    ),
                  ),
                  (_) {
                    // If deleted chat was active, clear active chat
                    if (ref.read(activeChatProvider) == chat.id) {
                      ref.read(activeChatProvider.notifier).clear();
                    }
                  },
                );
                if (context.mounted) context.pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showRenameDialog(
    BuildContext context,
    WidgetRef ref,
    ChatSession chat,
  ) {
    final controller = TextEditingController(text: chat.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Chat'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New Title'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final newTitle = controller.text.trim();
                if (newTitle.isNotEmpty) {
                  final updateChatTitle = ref.read(
                    updateChatTitleUseCaseProvider,
                  );
                  final result = await updateChatTitle(
                    UpdateChatTitleParams(chat.id, newTitle),
                  );

                  result.fold(
                    (failure) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error updating title: ${failure.message}',
                        ),
                      ),
                    ),
                    (_) => null,
                  );
                }
                if (context.mounted) context.pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  String _cleanTitle(String title) {
    return title.replaceAll(RegExp(r'[*_~`]'), '');
  }
}
