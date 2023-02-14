import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wash_mesh/admin_chat_module/widgets/chat/admin_messages.dart';
import 'package:wash_mesh/admin_chat_module/widgets/chat/admin_new_messages.dart';
import 'package:wash_mesh/register_screen.dart';

class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({Key? key}) : super(key: key);

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
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
            borderRadius: BorderRadius.circular(16),
            dropdownColor: Colors.blue,
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'clear',
                child: Row(
                  children: const [
                    Icon(
                      Icons.clear_all,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Clear Chat',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                    (route) => false);
              }
              if (value == 'clear') {
                deleteAll();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: AdminMessages()),
          const AdminNewMessages(),
        ],
      ),
    );
  }
}
