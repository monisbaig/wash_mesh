import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';
import 'package:wash_mesh/widgets/custom_multiselect.dart';

import '../providers/user_provider/user_auth_provider.dart';
import '../widgets/custom_logo.dart';

class AdminServices extends StatefulWidget {
  const AdminServices({Key? key}) : super(key: key);

  @override
  State<AdminServices> createState() => _AdminServicesState();
}

class _AdminServicesState extends State<AdminServices> {
  List<String> _selectedWashItems = [];
  List<String> _selectedMeshItems = [];

  void _showWashCategory(snapshot) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomMultiSelect(items: snapshot);
      },
    );

    if (results != null) {
      setState(() {
        _selectedWashItems = results;
      });
    }
  }

  _showMeshCategory(snapshot) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomMultiSelect(items: snapshot);
      },
    );

    if (results != null) {
      setState(() {
        _selectedMeshItems = results;
      });
    }
  }

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
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Services',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/wash.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: _selectedMeshItems
                          .map(
                            (e) => Chip(
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: CustomColor().mainColor,
                                fontSize: 16,
                              ),
                              label: Text(e),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      onTextPress: () async {
                        // FutureBuilder<Meshusermodel>(
                        //   future: UserAuthProvider.Getmeshcategories(),
                        //   builder: (context, snapshot) {
                        //     return _showMeshCategory(snapshot.data!);
                        //   },
                        // );
                        List<String> str = [];
                        await UserAuthProvider.getwashnames()
                            .then((value) => str = value);
                        return _showMeshCategory(str.toList());
                      },
                      buttonText: 'Select Wash Service',
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/mesh.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: _selectedWashItems
                          .map(
                            (e) => Chip(
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: CustomColor().mainColor,
                                fontSize: 16,
                              ),
                              label: Text(e),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      onTextPress: () async {
                        // FutureBuilder<Meshusermodel>(
                        //   future: UserAuthProvider.Getmeshcategories(),
                        //   builder: (context, snapshot) {
                        //     return _showMeshCategory(snapshot.data!);
                        //   },
                        // );
                        List<String> str = [];
                        await UserAuthProvider.getmeshnames()
                            .then((value) => str = value);
                        return _showWashCategory(str.toList());
                        print(str.toString());
                      },
                      buttonText: 'Select Mesh Service',
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
