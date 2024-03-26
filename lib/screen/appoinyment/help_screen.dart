import 'package:d_scan/screen/home/homepage.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.bgColor,
      appBar: AppBar(
        backgroundColor: HomeColors.appBarbgColor,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(HomePage());
            },
            child: Text(
              "হোম",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Text(
          "জানুন",
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.bold,
            color: HomeColors.appbarTextcolor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.all(14),
            child: Image.asset(
              "assets/icon/arrowback.png",
            ),
          ),
        ),
      ),
    );
  }
}
