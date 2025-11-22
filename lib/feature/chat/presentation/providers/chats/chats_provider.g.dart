// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isBotTypingHash() => r'03db5dbd844679fce41dd2045b9645ad2d043459';

/// See also [IsBotTyping].
@ProviderFor(IsBotTyping)
final isBotTypingProvider =
    AutoDisposeNotifierProvider<IsBotTyping, bool>.internal(
      IsBotTyping.new,
      name: r'isBotTypingProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$isBotTypingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$IsBotTyping = AutoDisposeNotifier<bool>;
String _$chatsHash() => r'6e3ee0060631d52afa2c272145a52b8ee66da0c5';

/// See also [Chats].
@ProviderFor(Chats)
final chatsProvider =
    AutoDisposeStreamNotifierProvider<Chats, List<Message>>.internal(
      Chats.new,
      name: r'chatsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$chatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Chats = AutoDisposeStreamNotifier<List<Message>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
