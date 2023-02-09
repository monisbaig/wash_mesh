import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/models/user_models/Meshusermodel.dart';
import 'package:wash_mesh/providers/user_provider/user_auth_provider.dart';
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
            child: FutureBuilder<Meshusermodel>(
                future: UserAuthProvider.Getmeshcategories(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Padding(
                          padding: EdgeInsets.only(top: 320),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 45.h, horizontal: 12.w),
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
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => WashBookScreen(),));
                                      },
                                      child: Column(
                                        children: [
                                          // Image.network(
                                          //   snapshot.data!.data!.elementAt(index).image!,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            snapshot.data!.data!
                                                .elementAt(index)
                                                .name!,
                                          ),
                                        ],
                                      ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      3,
                                      (index) => InkWell(
                                            onTap: () {},
                                            child: Column(
                                              children: [
                                                // Image.network(
                                                // snapshot.data!.data!.elementAt(index).image!,
                                                //   fit: BoxFit.cover,
                                                // ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  snapshot.data!.data!
                                                      .elementAt(index)
                                                      .name!,
                                                )
                                              ],
                                            ),
                                          ))),
                            ],
                          ),
                        );
                })),
      ),
    );
  }
}
