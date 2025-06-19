import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/core/widget/app_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/chat_cubit.dart';
import '../controller/chat_state.dart';
import '../controller/messages_cubit.dart';
import '../repo/chat_repo.dart';
import 'widgets/chat_card_item.dart';
import 'display_chat_screen.dart';

class DliveryManChatScreen extends StatelessWidget {
  static const String routeName = "DliveryManChatScreen";

  const DliveryManChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(ChatRepository())..loadChats(),
      child: Scaffold(
        drawer: drawer(context),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.purple[400],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "المحادثات",
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChatLoaded) {
                      final chats = state.chats;
                      if (chats.isEmpty) {
                        return const Center(child: Text("لا توجد محادثات"));
                      }
                      return ListView.separated(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) =>
                                        MessagesCubit(ChatRepository())
                                          ..loadMessages(chat.chatId),
                                    child: DisplayChatScreen(
                                      name: chat.name,
                                      imagePath: chat.imageUrl,
                                      
                                      chatId: chat.chatId,
                                      currentUserId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ChatCardItem(
                              imagePath: chat.imageUrl,
                              message: chat.lastMessage,
                              name: chat.name,
                              time: _formatTime(chat.lastMessageTime),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                      );
                    } else if (state is ChatError) {
                      log(state.message);
                      return Center(
                          child: Text(state.message,
                              style: const TextStyle(color: Colors.red)));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}
