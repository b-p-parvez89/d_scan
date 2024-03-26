import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan/screen/home/homepage.dart';
import 'package:d_scan/screen/leser/leserDetails.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors/homepage_color.dart';

class LessarPage extends StatefulWidget {
  const LessarPage({super.key});

  @override
  State<LessarPage> createState() => _LessarPageState();
}

class _LessarPageState extends State<LessarPage> {
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
            "লেসার কসমেটিক",
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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('leser_tridment')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return Card(
                            color: Color.fromARGB(255, 4, 147, 243)
                                .withOpacity(0.5),
                            child: ListTile(
                              title: Text(
                                data['name'],
                                style: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "মাত্রঃ  ৳ ${data['price']}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: HomeColors.buttonColors,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(
                                      "বিস্তারিত",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  onTap: () {
                                    Get.to(LeserDetails(
                                      name: data['name'],
                                      details: data['details'],
                                      price: data['price'],
                                      image: data['image'],
                                    ));
                                  }),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}
