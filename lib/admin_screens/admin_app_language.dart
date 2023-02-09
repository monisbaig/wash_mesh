import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

import '../widgets/custom_logo.dart';

class AdminAppLanguage extends StatefulWidget {
  const AdminAppLanguage({Key? key}) : super(key: key);

  @override
  State<AdminAppLanguage> createState() => _AdminAppLanguageState();
}

class _AdminAppLanguageState extends State<AdminAppLanguage> {
  bool? isEnglish = false;
  bool? isUrdu = false;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      ch: Padding(
        padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
        child: Column(
          children: [
            const CustomLogo(),
            SizedBox(height: 15.h),
            Container(
              alignment: Alignment.center,
              child: Text(
                'firstName'.tr(),
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            InkWell(
              onTap: () {
                context.setLocale(const Locale('en', 'US'));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: isEnglish,
                    onChanged: (bool? value) {
                      setState(() {
                        isEnglish = value;
                      });
                    },
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'English',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                width: 270.w,
                child: Divider(height: 10.h, thickness: 2),
              ),
            ),
            InkWell(
              onTap: () {
                context.setLocale(const Locale('ur', 'PAK'));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: isUrdu,
                    onChanged: (bool? value) {
                      setState(() {
                        isUrdu = value;
                      });
                    },
                  ),
                  SizedBox(width: 26.w),
                  Text(
                    'Urdu',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      op: 0.1,
    );
  }
}
