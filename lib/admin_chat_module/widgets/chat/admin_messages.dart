import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wash_mesh/admin_map_integration/admin_global_variables/admin_global_variables.dart';

import 'admin_message_bubble.dart';

class AdminMessages extends StatelessWidget {
  const AdminMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => AdminMessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['vendorId'] == currentAdminUser!.uid,
            ValueKey(chatDocs[index].id),
            chatDocs[index]['vendorName'],
          ),
        );
      },
    );
  }
}
