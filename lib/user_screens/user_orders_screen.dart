import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

import '../models/user_models/orders_model.dart' as or;
import '../providers/user_provider/user_auth_provider.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({Key? key}) : super(key: key);

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  List<or.OrdersModel> orderList = [];

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<or.OrdersModel>(
            future: UserAuthProvider.getOrders(),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'All User Orders',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  minVerticalPadding: 10,
                                  leading: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Amount :"),
                                      SizedBox(height: 10.h),
                                      Text(
                                        "${snapshot.data!.data!.elementAt(index).amount}",
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    "Status : ${snapshot.data!.data!.elementAt(index).status}",
                                  ),
                                  subtitle: Text(
                                    "Description : ${snapshot.data!.data!.elementAt(index).description}",
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Text(
                                          'Reject',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      InkWell(
                                        onTap: () {},
                                        child: const Text(
                                          'Accept',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
