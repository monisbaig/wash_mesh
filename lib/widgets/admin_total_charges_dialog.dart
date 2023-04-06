import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';

class AdminTotalChargesDialog extends StatefulWidget {
  final String totalFareAmount;

  const AdminTotalChargesDialog({super.key, required this.totalFareAmount});

  @override
  State<AdminTotalChargesDialog> createState() =>
      _AdminTotalChargesDialogState();
}

class _AdminTotalChargesDialogState extends State<AdminTotalChargesDialog> {
  String? extraCharges;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        margin: const EdgeInsets.all(6),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Total Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 1,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              widget.totalFareAmount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(22),
              ),
              width: 200.w,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter extra charges',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  extraCharges = value;
                },
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please collect your amount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18),
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CustomNavigationBarAdmin(),
                      ),
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rs: ${widget.totalFareAmount}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
