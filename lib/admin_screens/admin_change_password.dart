import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';

import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_text_field.dart';

class AdminChangePassword extends StatefulWidget {
  const AdminChangePassword({Key? key}) : super(key: key);

  @override
  State<AdminChangePassword> createState() => _AdminChangePasswordState();
}

class _AdminChangePasswordState extends State<AdminChangePassword> {
  TextEditingController newPassword = TextEditingController();
  final formKey = GlobalKey<FormFieldState>();

  onPassChange() async {
    final adminPassword = Provider.of<AuthProvider>(context, listen: false);
    try {
      final result = await adminPassword.updateAdminPassword(
        newPassword: newPassword.text,
      );
      newPassword.clear();
      // Password Upadate Successfully!
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
    return CustomNavigationBarAdmin(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 33.h),
            const CustomLogo(),
            SizedBox(height: 15.h),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Change Password',
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
            SizedBox(height: 250.h),
            CustomButton(
              onTextPress: onPassChange,
              buttonText: 'Confirm',
              v: 15.h,
              h: 110.w,
            ),
            SizedBox(height: 33.h),
          ],
        ),
      ),
    );
  }
}
