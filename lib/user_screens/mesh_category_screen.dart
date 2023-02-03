import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

import '../widgets/custom_logo.dart';

class MeshCategory extends StatefulWidget {
  const MeshCategory({Key? key}) : super(key: key);

  @override
  State<MeshCategory> createState() => _MeshCategoryState();
}

class _MeshCategoryState extends State<MeshCategory> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomLogo(),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Image.asset(
                    'assets/images/mesh.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 420.h,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(
                          'assets/images/mechanic.png',
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10.h),
                        const Text('Mechanic'),
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
                        'assets/images/mechanic.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Ahmed'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/mechanic.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Ali'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/mechanic.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Husnain'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
