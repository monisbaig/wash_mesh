import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/models/user_models/Place.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';
import 'package:wash_mesh/widgets/custom_dropdownbutton.dart';
import '../../models/user_models/Categories.dart' as um;
import '../widgets/custom_logo.dart';

class WashBookScreen extends StatefulWidget {
  static late List<um.Data> data;

  WashBookScreen(List<um.Data> d) {
    data = d;
    print(data);
  }

  @override
  State<WashBookScreen> createState() => _WashBookScreenState();
}

class _WashBookScreenState extends State<WashBookScreen> {
  TextEditingController desp = TextEditingController();
  List<String> _catname = [];
  List<String> _carname = [];
  String? catname;
  String? carname;
  int _catid = 0;
  int _att_id = 0;
  int _att_val = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < WashBookScreen.data.length; i++) {
      _catname.add(WashBookScreen.data[i].name);
      for (int j = 0;
          j < WashBookScreen.data.elementAt(i).catAttribute!.length;
          j++) {
        for (int k = 0;
            k <
                WashBookScreen.data
                    .elementAt(i)
                    .catAttribute!
                    .elementAt(j)
                    .attribute!
                    .attributeValue!
                    .length;
            k++) {
          _carname.add(WashBookScreen.data
              .elementAt(i)
              .catAttribute!
              .elementAt(j)
              .attribute!
              .attributeValue!
              .elementAt(k)
              .name);
        }
      }
      setState(() {});
    }

    catname = _catname.first;
    carname = _carname.first;
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
                DropdownButton<String>(
                  value: catname,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _catid = _catname.indexOf(value!);
                      catname = value;
                    });
                  },
                  items: _catname.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.h),
                DropdownButton<String>(
                  value: carname,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _catid = _catname.indexOf(value!);
                      carname = value;
                    });
                  },
                  items: _catname.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                        controller: desp,
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
