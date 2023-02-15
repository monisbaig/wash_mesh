import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserMessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final bool isMe;
  final Key myKey;

  const UserMessageBubble(this.message, this.isMe, this.myKey, this.username,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140.w,
          margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
              bottomLeft: !isMe ? Radius.circular(0.r) : Radius.circular(12.r),
              bottomRight: isMe ? Radius.circular(0.r) : Radius.circular(12.r),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).primaryTextTheme.displayLarge!.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).primaryTextTheme.displayLarge!.color,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
