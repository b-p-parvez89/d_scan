import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors/homepage_color.dart';

class LeserDetails extends StatelessWidget {
  final String name;
  final String details;
  final String image;
  final String price;

  const LeserDetails(
      {super.key,
      required this.name,
      required this.details,
      required this.image,
      required this.price});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String bgImage = "assets/photo/bgimage.jpg";
    return Scaffold(
        backgroundColor: HomeColors.bgColor,
        appBar: AppBar(
          backgroundColor: HomeColors.appBarbgColor,
          title: Text(
            name,
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
        body: Stack(children: [
          Image.asset(
            bgImage,
            height: size.height,
            width: size.width,
            fit: BoxFit.cover,
          ),
          Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250.h,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 320.h,
                      child: SingleChildScrollView(
                        child: Text(
                          details,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: HomeColors.textColors,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "টাকাঃ ${price}৳ মাত্র",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: HomeColors.textColors,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CupertinoButton(
                        color: HomeColors.buttonColors,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "কল করুন",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: HomeColors.white,
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Icon(Icons.call)
                          ],
                        ),
                        onPressed: () async {
                          final url = 'tel:8801797709709';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        })
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
