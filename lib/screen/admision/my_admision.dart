import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:d_scan/screen/admision/make_admisionmainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/colors/homepage_color.dart';
import '../appoinyment/help_screen.dart';

class MYAddmishion extends StatelessWidget {
  String formateDate(DateTime date) {
    return DateFormat('M/d/y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Text('User not logged in');
    }

    final userId = currentUser.uid;
    final userCollectionRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
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
            "ভর্তি আছে",
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
              color: HomeColors.bgColor,
              child: StreamBuilder<QuerySnapshot>(
                stream: userCollectionRef.collection('allAdmision').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final admisionDataDocs = snapshot.data!.docs;
                  if (admisionDataDocs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 250.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/icon/sad_imoji.png"),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "আপনি এখন পর্যন্ত কোনো ভর্তি ক করেন নি!",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: HomeColors.iconColor,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "অনুগ্রহ করে আগে ভর্তি সম্পুর্ন করুন।   ভর্তি করতে নিচের বাটন এ ক্লিক করুন অথবা হোম পেজে ফেরত জান",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: HomeColors.iconColor,
                              ),
                            ),
                            SizedBox(height: 32),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(CheckDataPage());
                                },
                                child: Text(
                                  "ভর্তি হন",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: admisionDataDocs.length,
                      itemBuilder: (context, index) {
                        final admisionData = admisionDataDocs[index].data()
                            as Map<String, dynamic>;
                        final date = formateDate(
                            (admisionData['date'] as Timestamp).toDate());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Color.fromARGB(255, 76, 73, 252)
                                .withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 14),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          "রোগীর আইডী: ${admisionData['id']}",
                                          style: TextStyle(
                                              color: HomeColors.textColors,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 300.w,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              "রোগীর নামেঃ ${admisionData['patientName']}",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 120.w,
                                              child: Text(
                                                "ভর্তির তারিখঃ $date",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(right: 8.0),
                                //   child: GestureDetector(
                                //     // onTap: () {
                                //     //   Get.to(AdmisionDetails(
                                //     //     name: admisionData['patientName'],
                                //     //     id: admisionData['id'],
                                //     //     startDate: (admisionData['date']
                                //     //             as Timestamp)
                                //     //         .toDate(), // Pass DateTime object
                                //     //     maincouse: admisionData['maincouse'],
                                //     //     subcouse: admisionData['subcouse'],
                                //     //   ));
                                //     // },
                                //     child: Container(
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: 24, vertical: 8),
                                //       decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(12),
                                //           color: HomeColors.buttonColors),
                                //       child: Center(
                                //         child: Text("বিবরণ"),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}
