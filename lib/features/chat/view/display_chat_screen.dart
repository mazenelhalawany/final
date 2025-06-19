import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/features/chat/controller/chat_state.dart';
import 'package:flutter_application_9_final_project/features/chat/controller/messages_cubit.dart';
import 'package:flutter_application_9_final_project/features/chat/view/widgets/sending_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/message_model.dart';

class DisplayChatScreen extends StatelessWidget {
  final String chatId;
  final String currentUserId;
  final String name;
  final String imagePath;
  const DisplayChatScreen({
    super.key,
    required this.chatId,
    required this.currentUserId,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.purple[400],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name,
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(imagePath),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MessagesLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.senderId == currentUserId;
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.purple : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            msg.content,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          MessageInput(
            onGallerySelect: () {
              // Implement gallery selection if needed
            },
            controller: controller,
            onSend: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                final msg = MessageModel(
                  senderId: currentUserId,
                  content: text,
                  timestamp: DateTime.now(),
                );
                context.read<MessagesCubit>().sendMessage(chatId, msg);
                controller.clear();
              }
            },
          )
        ],
      ),
    );
  }
}
