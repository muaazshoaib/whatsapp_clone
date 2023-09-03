import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/chat/widgets/bottom_chat_field.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';

  final String name;
  final String uid;
  final bool isGroupChat;

  const MobileChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: isGroupChat
            ? Text(name)
            : StreamBuilder<UserModel>(
                stream: ref.read(authControllerProvider).userDataById(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                      ),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              receiverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ),
          BottomChatField(
            receiverUserId: uid,
            isGroupChat: isGroupChat,
          ),
        ],
      ),
    );
  }
}
