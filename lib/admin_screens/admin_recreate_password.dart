// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/admin_provider/admin_auth_provider.dart';
import '../widgets/custom_background.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_text_field.dart';

class AdminRecreatePassword extends StatefulWidget {
  const AdminRecreatePassword({Key? key}) : super(key: key);

  @override
  State<AdminRecreatePassword> createState() => _AdminRecreatePasswordState();
}

class _AdminRecreatePasswordState extends State<AdminRecreatePassword> {
  TextEditingController newPassword = TextEditingController();
  final formKey = GlobalKey<FormFieldState>();

  onPassChange() async {
    final adminPassword =
        Provider.of<AdminAuthProvider>(context, listen: false);
    try {
      final result = await adminPassword.updateAdminPassword(
        newPassword: newPassword.text,
      );
      newPassword.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$result'),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: Padding(
        padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
        child: Column(
          children: [
            const CustomLogo(),
            SizedBox(height: 15.h),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Re-Create Password',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 100.h),
            Form(
              key: formKey,
              child: CustomTextField(
                hint: 'Enter your new Password',
                controller: newPassword,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Please enter your password with at least 5 characters';
                  }
                  return null;
                },
              ),
            ),
            Expanded(child: Container()),
            CustomButton(
              onTextPress: onPassChange,
              buttonText: 'Okay',
            ),
          ],
        ),
      ),
    );
  }
}
