import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

class WashCategory extends StatefulWidget {
  const WashCategory({Key? key}) : super(key: key);

  @override
  State<WashCategory> createState() => _WashCategoryState();
}

class _WashCategoryState extends State<WashCategory> {
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
                  children: [
                    Image.asset(
                      'assets/images/wash.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 420.h,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            'assets/images/car-wash.png',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10.h),
                          const Text('Car Wash'),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      'Featured',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/car-wash.png',
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10.h),
                        const Text('Ahmed'),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/car-wash.png',
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10.h),
                        const Text('Ali'),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/car-wash.png',
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10.h),
                        const Text('Husnain'),
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
