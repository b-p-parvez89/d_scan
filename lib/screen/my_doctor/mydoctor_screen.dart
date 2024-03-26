import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan/screen/my_doctor/doctorDetailsPage.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/homepage.dart';

class MyFavoriteScreen extends StatelessWidget {
  const MyFavoriteScreen({Key? key});

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
          "জনপ্রিয় ডাক্তার",
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('best_doctor')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No doctors found'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doctorData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Get.to(DoctorDetailsPage(
                            name: doctorData['name'],
                            image: doctorData['image'],
                            date: doctorData['day'],
                            time: doctorData['time'],
                            deggree: doctorData['degree'],
                            type: doctorData['type'],
                            abouts: doctorData['details']));
                      },
                      child: Card(
                        color:
                            Color.fromARGB(255, 76, 73, 252).withOpacity(0.3),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 120.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            NetworkImage(doctorData['image']))),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctorData['name'],
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w900,
                                          color: HomeColors.textColors),
                                    ),
                                    Text(
                                      doctorData['degree'],
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: HomeColors.textColors),
                                    ),
                                    Text(
                                      doctorData['type'],
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: HomeColors.textColors),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  makePhoneCall('8801797709709');
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: HomeColors.buttonColors,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "সিরিয়াল",
                                        style: TextStyle(
                                            color: HomeColors.white,
                                            fontSize: 14.sp),
                                      ),
                                      Icon(
                                        Icons.call,
                                        color: HomeColors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
