import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_checkbox.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';

import '../widgets/custom_logo.dart';

class AdminServices extends StatefulWidget {
  const AdminServices({Key? key}) : super(key: key);

  @override
  State<AdminServices> createState() => _AdminServicesState();
}

class _AdminServicesState extends State<AdminServices> {
  bool isChecked = false;
  List washItems = [
    'Car Wash',
    'Car Detailing',
    'House Wash',
    'Upholstery Cleaning',
    'Water Tank Cleaning',
    'Laundry',
  ];
  List meshItems = [
    'Electrician',
    'Plumber',
    'Carpenter',
    'Painter',
    'Mechanic',
    'Labor',
    'AC Expert',
    'House Maid',
    'Beauty & Healthcare',
    'Gardner',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBarAdmin(
      op: 0.1,
      ch: SafeArea(
        child: Column(
          children: [
            const CustomLogo(),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/wash.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/mesh.png',
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              child: Column(
                children: [
                  CustomCheckBox(
                    catText: 'Car Wash',
                    onCheck: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    isChecked: isChecked,
                  ),
                  CustomCheckBox(
                    catText: 'Car Wash',
                    onCheck: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    isChecked: isChecked,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// GridView.builder(
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 1,
// mainAxisExtent: 40,
// ),
// itemCount: washItems.length,
// padding: const EdgeInsets.only(right: 16),
// itemBuilder: (context, index) => Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Checkbox(
// value: isChecked,
// onChanged: (bool? value) {
// setState(() {
// isChecked = value;
// });
// },
// ),
// Flexible(
// child: Text(
// washItems[index],
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// fontSize: 18.sp,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ],
// ),
// ),
