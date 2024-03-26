import 'package:d_scan/screen/appoinyment/help_screen.dart';
import 'package:d_scan/screen/appoinyment/my_doctor_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors/homepage_color.dart';
import '../my_doctor/doctorDetailsPage.dart';

class AppointmentPage extends StatelessWidget {
  final MyDoctorsController myDoctorsController =
      Get.put(MyDoctorsController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String bgImage = "assets/photo/bgimage.jpg";

    return Scaffold(
      backgroundColor: HomeColors.bgColor,
      appBar: AppBar(
        backgroundColor: HomeColors.appBarbgColor,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(HelpScreen());
            },
            child: Text(
              "জানুন",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Text(
          "ডাক্তার নির্বাচন করুন",
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      child: Center(
                        child: TextField(
                          controller: searchController,
                          onChanged: myDoctorsController.filterDoctors,
                          textAlign: TextAlign.center,
                          autofocus: false,
                          style: TextStyle(
                            color: HomeColors.iconColor,
                            fontSize: 20.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: "ডাক্তারের নাম অথবা ধরন লিখুন",
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              color: HomeColors.iconColor,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: HomeColors.iconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(() => Container(
                        height: 550.h,
                        child: ListView.builder(
                          itemCount: myDoctorsController.filteredDoctors.length,
                          itemBuilder: (context, index) {
                            var doctor =
                                myDoctorsController.filteredDoctors[index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorDetailsPage(
                                       
                                          name: doctor['nameByBangla'],
                                          time: doctor['time'],
                                          date: doctor['day'],
                                          image: doctor['image'],
                                          deggree: doctor['degree'],
                                          type: doctor['type'],
                                          abouts: doctor['details']),
                                    ),
                                  );
                                },
                                leading: Container(
                                  height: 80.h,
                                  width: 60.w,
                                  color: const Color.fromRGBO(244, 67, 54, 1)
                                      .withOpacity(0.2),
                                  child: doctor['image'] == null
                                      ? Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 60,
                                          ),
                                        )
                                      : Image.network(
                                          doctor['image'],
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                title: Text(
                                  doctor['nameByBangla'],
                                  style: TextStyle(
                                    color: HomeColors.appbarTextcolor,
                                    fontSize: 18.h,
                                  ),
                                ),
                                subtitle: Text(doctor['type']),
                              ),
                            );
                          },
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
