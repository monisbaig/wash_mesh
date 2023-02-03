import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

import '../widgets/custom_logo.dart';

class AdminAppLanguage extends StatelessWidget {
  const AdminAppLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? isChecked = false;
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
                'Select Language',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    isChecked = value;
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
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                width: 270.w,
                child: Divider(height: 10.h, thickness: 2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    isChecked = value;
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
          ],
        ),
      ),
      op: 0.1,
    );
  }
}
