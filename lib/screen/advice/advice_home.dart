import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/expanded_tile.dart';
import '../home/homepage.dart';




class AdviceHome extends StatelessWidget {
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
            "উপদেশ",
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
            color: HomeColors.myDoctorHomes,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('advice').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                  );
                } else {
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return CustomExpansionTile(
                        title: data['title'],
                        subtitle: data['subtile'],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          )
        ]));
  }
}
