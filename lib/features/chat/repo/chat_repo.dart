import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_9_final_project/features/chat/model/message_model.dart';
import '../model/list_chate_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// دي بتجيب كل المحادثات اللي المستخدم الحالي مشارك فيها
  Stream<List<ChatModel>> getUserChats() {
    final user = _auth.currentUser;

    // لو مفيش حد مسجل دخول، نرجع ستريم فاضي
    if (user == null) return Stream.value([]);

    final currentUserId = user.uid;
    log('👤 Current User ID: $currentUserId');

    // نسمع لتغيرات الداتا من مجموعة المحادثات (chats)
    return _firestore
        .collection('chats')
        .where('participants',
            arrayContains: currentUserId) // المحادثات اللي فيها المستخدم
        .orderBy('lastMessageTime', descending: true) // ترتيب حسب آخر رسالة
        .snapshots()
        .asyncMap((snapshot) async {
      // بنطبع عدد المحادثات اللي جت
      log('📥 Fetched ${snapshot.docs.length} chat(s) from Firestore');

      // بنعمل map علشان نحول كل دوكيومنت لـ ChatModel
      final futures = snapshot.docs.map((doc) async {
        final data = doc.data();

        // بنطلع الـ participants وندور على غير المستخدم الحالي
        List participants = List.from(data['participants'] ?? []);
        String otherUserId = participants.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );

        // نجيب بيانات المستخدم التاني من مجموعة users
        final userDoc =
            await _firestore.collection('users').doc(otherUserId).get();
        final userData = userDoc.data() ?? {};

        // نحول الداتا لـ ChatModel
        final chat = ChatModel(
          chatId: doc.id,
          otherUserId: otherUserId,
          name: userData['name'] ?? 'Unknown',
          imageUrl: userData['imageUrl'] ??
              'https://as2.ftcdn.net/v2/jpg/02/15/84/43/1000_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg',
          lastMessage: data['lastMessage'] ?? '',
          lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate() ??
              DateTime.now(),
        );

        // نطبع التفاصيل علشان الديباج
        log('🔹 Chat Loaded: ${chat.chatId}');
        log('👤 Name: ${chat.name}');
        log('💬 Last Message: ${chat.lastMessage}');
        log('🕒 Time: ${chat.lastMessageTime}');
        log('-------------------------');

        return chat;
      }).toList();

      // نستنى كل العمليات تخلص
      return await Future.wait(futures);
    });
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => MessageModel.fromMap(e.data())).toList());
  }

  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());

    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': message.content,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }
}
