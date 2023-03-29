import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

import '../providers/user_provider/user_auth_provider.dart';
import '../widgets/custom_background.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_logo.dart';

class UserRecreatePassword extends StatefulWidget {
  const UserRecreatePassword({Key? key}) : super(key: key);

  @override
  State<UserRecreatePassword> createState() => _UserRecreatePasswordState();
}

class _UserRecreatePasswordState extends State<UserRecreatePassword> {
  TextEditingController newPassword = TextEditingController();
  final formKey = GlobalKey<FormFieldState>();

  onPassChange() async {
    final adminPassword = Provider.of<UserAuthProvider>(context, listen: false);
    try {
      final result = await adminPassword.recreateUserPassword(
        newPassword: newPassword.text,
      );
      newPassword.clear();
      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: result);
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
            SizedBox(height: 33.h),
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
