import 'package:d_scan/screen/my_appointment/cancaled_servies.dart';
import 'package:d_scan/screen/my_appointment/completed_servise.dart';
import 'package:d_scan/screen/my_appointment/up_coming_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors/homepage_color.dart';
import '../home/homepage.dart';

class MyAppointment extends StatefulWidget {
  const MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    String bgImage = "assets/photo/bgimage.jpg";
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: HomeColors.bgColor,
          appBar: AppBar(
            title: Text(
              "ডাক্তার পরিচিতি",
              style: TextStyle(
                fontSize: 22.sp,
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
            backgroundColor: HomeColors.appBarbgColor,
            actions: [
              TextButton(
                  onPressed: () {
                    Get.to(HomePage());
                  },
                  child: Text(
                    "হোম",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: HomeColors.appbarTextcolor,
                    ),
                  ))
            ],
            bottom: TabBar(
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                tabs: [
                  Tab(
                    text: "পরমর্শ বাকি আছে",
                  ),
                  Tab(
                    text: "দেখা সম্পুর্ন হয়েছে",
                  ),
                  Tab(
                    text: "বাতিল করা হয়েছে",
                  )
                ]),
          ),
          body: Stack(
            children: [
              Image.asset(
                bgImage,
                height: size.height,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Container(
                height: size.height,
                width: size.width,
                color: HomeColors.myDoctorHomes,
                child: TabBarView(children: [
                  MyAppointmentsWidget(),
                  CompletedAppoinment(),
                  CanceledAppoinment()
                ]),
              )
            ],
          ),
        ));
  }
}
