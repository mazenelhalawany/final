import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/chat_repo.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  ChatCubit(this.repository) : super(ChatInitial());

  void loadChats() {
    emit(ChatLoading());
    repository.getUserChats().listen(
      (chats) {
        emit(ChatLoaded(chats));
      },
      onError: (error) {
        emit(ChatError(error.toString()));
      },
    );
  }
}