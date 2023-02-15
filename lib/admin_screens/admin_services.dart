import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/models/user_models/Categories.dart' as wc;
import 'package:wash_mesh/providers/admin_provider/admin_auth_provider.dart';
import 'package:wash_mesh/providers/auth_provider.dart';
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
  List<int> _selectedwashcat = [];
  List<String> _selectedMeshItems = [];
  List<int> _selectedmeshcat = [];
  nameid dt = nameid();

  // void _showWashCategory(snapshot) async {
  //   final List<String>? results = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CustomMultiSelect(items: snapshot);
  //     },
  //   );

  //   if (results != null) {
  //     setState(() {
  //       _selectedWashItems = results;
  //     });
  //   }
  // }

  void _washItemChange(String itemValue, bool isSelected, nameid i) {
    setState(() {
      if (isSelected) {
        _selectedWashItems.add(itemValue);
        int place = i.lstname.indexOf(itemValue);
        _selectedwashcat.add(i.lstcatid.elementAt(place));
      } else {
        int place = _selectedWashItems.indexOf(itemValue);
        _selectedWashItems.remove(itemValue);
        _selectedwashcat.removeAt(place);
      }
    });
  }

  void _meshItemChange(String itemValue, bool isSelected, nameid i) {
    setState(() {
      if (isSelected) {
        _selectedMeshItems.add(itemValue);
        int place = i.lstname.indexOf(itemValue);
        _selectedmeshcat.add(i.lstcatid.elementAt(place));
      } else {
        int place = _selectedMeshItems.indexOf(itemValue);
        _selectedMeshItems.remove(itemValue);
        _selectedmeshcat.removeAt(place);
      }
    });
  }

  _showMeshCategory(nameid ijk) async {
    await showDialog<nameid>(
      context: context,
      builder: (BuildContext context) {
        int? selectedRadio = 0;
        return AlertDialog(
          title: const Text('Select Category'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                  children: List.generate(ijk.lstname.length, (index) {
                return CheckboxListTile(
                    value: _selectedWashItems.contains(ijk.lstname[index]),
                    title: Text(ijk.lstname[index]),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (v) {
                      _washItemChange(ijk.lstname[index], v!, ijk);

                      setState(() {});
                    });
              })),
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                print(_selectedWashItems);
                print(_selectedwashcat);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  _meshcat(nameid ijk) async {
    await showDialog<nameid>(
      context: context,
      builder: (BuildContext context) {
        int? selectedRadio = 0;
        return AlertDialog(
          title: const Text('Select Category'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                  children: List.generate(ijk.lstname.length, (index) {
                return CheckboxListTile(
                    value: _selectedMeshItems.contains(ijk.lstname[index]),
                    title: Text(ijk.lstname[index]),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (v) {
                      _meshItemChange(ijk.lstname[index], v!, ijk);

                      setState(() {});
                    });
              })),
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                print(_selectedMeshItems);
                print(_selectedmeshcat);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
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
                        nameid catidaname = nameid();
                        await UserAuthProvider.getwashnames()
                            .then((value) => catidaname = value);
                        return _showMeshCategory(catidaname);
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
                        nameid catidaname = nameid();
                        await UserAuthProvider.getmeshnames()
                            .then((value) => catidaname = value);
                        return _meshcat(catidaname);
                      },
                      buttonText: 'Select Mesh Service',
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      onTextPress: () async {
                        await Provider.of<UserAuthProvider>(context,
                                listen: false)
                            .applyvender(_selectedwashcat, _selectedmeshcat);
                      },
                      buttonText: 'Submit',
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
