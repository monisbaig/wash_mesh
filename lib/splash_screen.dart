// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/register_screen.dart';
import 'package:wash_mesh/user_map_integration/user_global_variables/user_global_variables.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';

import 'admin_map_integration/admin_global_variables/admin_global_variables.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 1,
      ch: Padding(
        padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomLogo(),
            CustomButton(
              buttonText: 'getStarted'.tr(),
              onTextPress: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                userToken = prefs.getString('userToken');
                adminToken = prefs.getString('token');

                if (prefs.getBool('userLoggedIn') == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomNavigationBar(),
                    ),
                    (route) => false,
                  );
                } else if (prefs.getBool('adminLoggedIn') == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomNavigationBarAdmin(),
                    ),
                    (route) => false,
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
