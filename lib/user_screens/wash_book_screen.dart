import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/models/user_models/Categories.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';
import 'package:wash_mesh/widgets/custom_dropdownbutton.dart';

import '../providers/user_provider/user_auth_provider.dart';
import '../widgets/custom_logo.dart';

class WashBookScreen extends StatefulWidget {
  static late int type_id;
  static late  Attribute attribute;

  // WashBookScreen(int id, Attribute a)
  // {
  //   type_id=id;
  //   attribute=a;
  // }

  @override
  State<WashBookScreen> createState() => _WashBookScreenState();
}

class _WashBookScreenState extends State<WashBookScreen> {



  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
            child: Column(
              children: [
                const CustomLogo(),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/wash.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomDropdownButton(
                  heading: 'Select your desired category',
                  selectColor: CustomColor().mainColor,
                  textColor: Colors.white,
                  dropDownText: 'Car Wash',
                ),
                SizedBox(height: 20.h),
                const CustomDropdownButton(
                  heading: 'Type of Car*',
                  selectColor: Colors.white,
                  textColor: Colors.black,
                  dropDownText: 'Truck',
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 45.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 22.w),
                  ],
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 320.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Attach Pictures',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        const Text(
                          '(Optional)',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 50.w),
                        const Icon(
                          Icons.attachment_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 320.w,
                      height: 200.h,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Description (Optional)',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Amount to be Paid:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      '300',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          onTextPress: () {},
                          buttonText: 'Book Now',
                          v: 11,
                          h: 15,
                        ),
                        CustomButton(
                          onTextPress: () {},
                          buttonText: 'Book Later',
                          v: 11,
                          h: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
