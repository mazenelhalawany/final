import 'package:bloc/bloc.dart';
import 'package:flutter_application_9_final_project/features/chat/model/message_model.dart';
import 'package:flutter_application_9_final_project/features/chat/repo/chat_repo.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this.repository) : super(MessagesInitial());
  final ChatRepository repository;

  void loadMessages(String chatId) {
    emit(MessagesLoading());
    repository.getMessages(chatId).listen((messages) {
      emit(MessagesLoaded(messages));
    });
  }

  Future<void> sendMessage(String chatId, MessageModel message) async {
    await repository.sendMessage(chatId: chatId, message: message);
  }
}
