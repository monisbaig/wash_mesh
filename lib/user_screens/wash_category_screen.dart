// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/user_screens/wash_book_screen.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

import '../models/user_models/wash_categories_model.dart' as um;
import '../providers/user_provider/user_auth_provider.dart';

class WashCategory extends StatefulWidget {
  const WashCategory({Key? key}) : super(key: key);

  @override
  State<WashCategory> createState() => _WashCategoryState();
}

class _WashCategoryState extends State<WashCategory> {
  List<um.WashCategoryModel> catlst = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    instance();
  }

  late final userData;

  instance() async {
    userData = Provider.of<UserAuthProvider>(context, listen: false);
  }

  final List<um.WashCategoryModel> _data = [];
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<um.WashCategoryModel>(
            future: UserAuthProvider.getWashCategories(),
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
                                'assets/images/wash.png',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  // .attribute!
                                  // .attributeValue!
                                  // .elementAt(index)
                                  // .id);
                                  List<um.Data> data = snapshot.data!.data!;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => WashBookScreen(
                                        data,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .name,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .id,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      snapshot.data!.data!
                                          .elementAt(index)
                                          .image,
                                      fit: BoxFit.contain,
                                      width: 80.w,
                                      height: 80.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Flexible(
                                      child: Text(
                                        "${snapshot.data!.data!.elementAt(index).name}",
                                        // overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                            children: List.generate(
                              3,
                              (index) => InkWell(
                                onTap: () async {
                                  // .attribute!
                                  // .attributeValue!
                                  // .elementAt(index)
                                  // .id);
                                  List<um.Data> data = snapshot.data!.data!;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => WashBookScreen(
                                        data,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .name,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .id,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      snapshot.data!.data!
                                          .elementAt(index)
                                          .image,
                                      fit: BoxFit.contain,
                                      width: 80.w,
                                      height: 80.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      snapshot.data!.data!
                                          .elementAt(index)
                                          .name,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
