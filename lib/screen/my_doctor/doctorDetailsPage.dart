import 'package:d_scan/screen/appoinyment/confrime_appointemt.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DoctorDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final String deggree;
  final String type;
  final List date;
  final List time;
  final String abouts;


  const DoctorDetailsPage(
      {super.key,
      required this.name,
      required this.image,
      required this.date,
      required this.time,
      required this.deggree,
      required this.type,
      required this.abouts});

  @override
  Widget build(BuildContext context) {
    String bgImage = "assets/photo/bgimage.jpg";
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HomeColors.bgColor,
      appBar: AppBar(
        backgroundColor: HomeColors.appBarbgColor,
        actions: [
        
        
        ],
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
            color: HomeColors.detailheaderColors,
            child: Column(
              children: [
                Container(
                  height: 300,
                  color: HomeColors.detailheaderColors.withOpacity(0.6),
                  child: Align(
                    child: Image.network(image, fit: BoxFit.fill,),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: HomeColors.detailsPageBottomColors,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      color: HomeColors.textColors,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        deggree,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: HomeColors.subtextColors,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    type,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: HomeColors.iconColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                    
                                      Container(
                                          decoration: BoxDecoration(
                                              color: HomeColors.iconColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6.h, horizontal: 10.w),
                                          child: Icon(
                                            Icons.call,
                                            color: Colors.white,
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 3.sp,
                          color: HomeColors.detailheaderColors,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "বিবরণঃ",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: HomeColors.textColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                abouts,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: HomeColors.textColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(ConfrimedAppoinment(
                              doctorname: name,
                              time: time, 
                              day: date,
                              type: type,
                              degree: deggree,
                              image:image,
                            ));
                          },
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: HomeColors.detailheaderColors,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                "সামনে এগিয়ে যান",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: HomeColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
