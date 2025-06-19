part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}

class Messagesitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MessageModel> messages;

  MessagesLoaded(this.messages);
}

class MessagesError extends MessagesState {
  final String message;

  MessagesError(this.message);
}
