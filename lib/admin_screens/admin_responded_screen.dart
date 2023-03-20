import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/models/admin_models/vendor_orders.dart';
import 'package:wash_mesh/providers/admin_provider/admin_auth_provider.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

class AdminRespondedScreen extends StatefulWidget {
  const AdminRespondedScreen({Key? key}) : super(key: key);

  @override
  State<AdminRespondedScreen> createState() => _AdminRespondedScreenState();
}

class _AdminRespondedScreenState extends State<AdminRespondedScreen> {
  @override
  Widget build(BuildContext context) {
    var vendorAuthProvider =
        Provider.of<AdminAuthProvider>(context, listen: false);

    return CustomBackground(
      op: 0.1,
      ch: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<VendorOrders>(
            future: AdminAuthProvider.getVendorOrders(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                      heightFactor: 12.h,
                      child: const Text(
                        textAlign: TextAlign.center,
                        'No orders available\n Thank you.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                    )
                  : snapshot.connectionState == ConnectionState.waiting
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
                                    'All Vendor Orders Response',
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
                                  var status = snapshot.data!.data!
                                      .elementAt(index)
                                      .status;
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
                                      title: status == '1'
                                          ? const Text('Pending')
                                          : const Text(''),
                                      subtitle: Text(
                                        "Description : ${snapshot.data!.data!.elementAt(index).description}",
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
