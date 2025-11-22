import 'package:ai_chat_app/feature/chat/presentation/pages/widgets/message_animator.dart';
import 'package:ai_chat_app/feature/chat/presentation/pages/widgets/typing_indicator.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/chat/domain/entities/message.dart';
import 'package:ai_chat_app/feature/chat/domain/usecases/chat_usecases.dart';
import 'package:ai_chat_app/feature/chat/presentation/providers/active_chat_provider.dart';
import 'package:ai_chat_app/feature/chat/presentation/pages/widgets/chat_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/chats/chats_provider.dart';
import 'widgets/appbar.dart';
import 'widgets/custom_textfield.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = 'chat';
  static const routeSetting = '/chat';

  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  List<Message> _lastMessages = [];

  @override
  void initState() {
    super.initState();
    // Defer state update to next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeChat();
    });
  }

  Future<void> _initializeChat() async {
    final activeChat = ref.read(activeChatProvider);
    if (activeChat == null) {
      await _startNewChat();
    }
  }

  Future<void> _startNewChat() async {
    final createChat = ref.read(createChatUseCaseProvider);
    final result = await createChat(NoParams());

    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating chat: ${failure.message}')),
      ),
      (newChatId) {
        ref.read(activeChatProvider.notifier).setActiveChat(newChatId);
      },
    );
  }

  void onSend() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      ref.read(chatsProvider.notifier).addMessage(message);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildMessageList(List<Message> messages) {
    final isBotTyping = ref.watch(isBotTypingProvider);
    // Only show typing indicator if bot is typing AND the last message is NOT from the bot
    // This prevents the spinner from lingering after the bot response has arrived
    final showTyping =
        isBotTyping && (messages.isEmpty || messages.first.role != 'model');

    final displayMessages = [
      if (showTyping)
        Message(
          id: 'typing',
          role: 'bot_typing',
          content: 'bot is typing',
          createdAt: DateTime.now(),
        ),
      ...messages,
    ];

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: displayMessages.length,
      itemBuilder: (context, index) {
        final msg = displayMessages[index];
        final isUser = msg.role == 'user';
        final isTyping = msg.role == 'bot_typing';

        if (isTyping) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16.r,
                  backgroundColor: theme.colorScheme.surface,
                  child: Icon(
                    Icons.smart_toy_rounded,
                    color: theme.colorScheme.onSurface,
                    size: 18.r,
                  ),
                ),
                SizedBox(width: 12.w),
                const TypingIndicator(),
              ],
            ),
          );
        }

        return MessageAnimator(
          key: ValueKey(msg.id),
          child: RepaintBoundary(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!isUser) ...[
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: theme.colorScheme.surface,
                      child: Icon(
                        Icons.smart_toy_rounded,
                        color: theme.colorScheme.onSurface,
                        size: 18.r,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color:
                            isUser
                                ? theme.colorScheme.primary
                                : theme.cardTheme.color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                          bottomLeft:
                              isUser ? Radius.circular(20.r) : Radius.zero,
                          bottomRight:
                              isUser ? Radius.zero : Radius.circular(20.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border:
                            isUser
                                ? null
                                : Border.all(
                                  color: theme.colorScheme.outline.withValues(
                                    alpha: 0.1,
                                  ),
                                  width: 1,
                                ),
                      ),
                      child: MarkdownBody(
                        data: msg.content,
                        selectable: true,
                        builders: {
                          'code': CodeElementBuilder(
                            isDark: isDark,
                            theme: theme,
                            isUser: isUser,
                          ),
                        },
                        styleSheet: MarkdownStyleSheet(
                          p: theme.textTheme.bodyMedium?.copyWith(
                            color:
                                isUser
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onSurface,
                            fontSize: 15.sp,
                            height: 1.4,
                          ),
                          code: theme.textTheme.bodySmall?.copyWith(
                            color:
                                isUser
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onSurface,
                            backgroundColor:
                                isUser
                                    ? Colors.white.withValues(alpha: 0.2)
                                    : theme.colorScheme.surfaceContainerHighest,
                            fontFamily: 'monospace',
                            fontSize: 13.sp,
                          ),
                          codeblockDecoration: BoxDecoration(
                            color:
                                isUser
                                    ? Colors.black.withValues(alpha: 0.2)
                                    : theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(
                                alpha: 0.2,
                              ),
                            ),
                          ),
                          tableBody: theme.textTheme.bodyMedium?.copyWith(
                            color:
                                isUser
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onSurface,
                          ),
                          tableHead: theme.textTheme.titleSmall?.copyWith(
                            color:
                                isUser
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                          tableBorder: TableBorder.all(
                            color:
                                isUser
                                    ? theme.colorScheme.onPrimary.withValues(
                                      alpha: 0.2,
                                    )
                                    : theme.colorScheme.outline.withValues(
                                      alpha: 0.2,
                                    ),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isUser) ...[
                    SizedBox(width: 8.w),
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person_rounded,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 18.r,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Message>>>(chatsProvider, (prev, next) {
      next.whenData((messages) {
        _lastMessages = messages; // update only on data
      });
    });

    final chatState = ref.watch(chatsProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: const ChatDrawer(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              children: [
                Appbar(),

                Expanded(
                  child: chatState.when(
                    data: (messages) => buildMessageList(messages),
                    loading: () => buildMessageList(_lastMessages),
                    error: (err, _) => buildMessageList(_lastMessages),
                  ),
                ),

                CustomTextfield(onSend: onSend, controller: _controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CodeElementBuilder extends MarkdownElementBuilder {
  final bool isDark;
  final ThemeData theme;
  final bool isUser;

  CodeElementBuilder({
    required this.isDark,
    required this.theme,
    required this.isUser,
  });

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isUser
                  ? Colors.black.withValues(alpha: 0.2)
                  : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          element.textContent,
          style: TextStyle(
            fontFamily: 'monospace',
            color: isUser ? Colors.white : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
