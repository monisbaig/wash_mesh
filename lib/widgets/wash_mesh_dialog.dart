import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

import '../user_screens/wash_book_screen.dart';

class WashMeshDialog extends StatelessWidget {
  const WashMeshDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: AlertDialog(
        backgroundColor: Colors.transparent,
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(height: 280.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>  WashBookScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/wash.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/mesh.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
