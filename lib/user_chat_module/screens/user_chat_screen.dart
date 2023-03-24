import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/chat/user_messages.dart';
import '../widgets/chat/user_new_messages.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({Key? key}) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  Future<void> deleteAll() async {
    final collection =
        await FirebaseFirestore.instance.collection("chat").get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          DropdownButton(
            elevation: 0,
            underline: Container(),
            borderRadius: BorderRadius.circular(16.r),
            dropdownColor: Colors.blue,
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    const Icon(
                      Icons.clear_all,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.w),
                    const Text(
                      'Clear Chat',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'clear') {
                deleteAll();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: UserMessages()),
          const UserNewMessages(),
        ],
      ),
    );
  }
}
