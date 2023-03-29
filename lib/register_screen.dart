// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/admin_screens/admin_login_form.dart';
import 'package:wash_mesh/user_map_integration/user_global_variables/user_global_variables.dart';
import 'package:wash_mesh/user_screens/user_login_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';

import 'admin_map_integration/admin_global_variables/admin_global_variables.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      ch: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const CustomLogo(),
            SizedBox(height: 50.h),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'register',
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ).tr(),
              ),
            ),
            SizedBox(height: 50.h),
            CustomButton(
              onTextPress: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                userToken = prefs.getString('userToken');
                if (prefs.getBool('userLoggedIn') == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomNavigationBar(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLoginForm(),
                    ),
                  );
                }
              },
              buttonText: 'customer'.tr(),
            ),
            SizedBox(height: 30.h),
            CustomButton(
              onTextPress: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                adminToken = prefs.getString('token');
                if (prefs.getBool('adminLoggedIn') == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomNavigationBarAdmin(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminLoginForm(),
                    ),
                  );
                }
              },
              buttonText: 'serviceProvider'.tr(),
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
      op: 0.1,
    );
  }
}
