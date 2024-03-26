import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../appoinyment/appointment_page.dart';

class CanceledAppoinment extends StatelessWidget {
  String formateDate(DateTime date) {
    return DateFormat('M/d/y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Return a widget indicating user not logged in
      return Text('User not logged in');
    }

    final userId = currentUser.uid;
    final userCollectionRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    return StreamBuilder<QuerySnapshot>(
      stream: userCollectionRef.collection('cancelAppoinment').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final appointmentDocs = snapshot.data!.docs;
        if (appointmentDocs.isEmpty) {
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
                        image: AssetImage("assets/icon/sad_imoji.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "আপনি এখন পর্যন্ত কোনো পরমর্শ সম্পুর্ন করেন নি!",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: HomeColors.iconColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "অনুগ্রহ করে পরমর্শ সম্পুর্ন করুন। পরমর্শ  সম্পুর্ন করতে নিচের বাটন এ ক্লিক করুন অথবা হোম পেজে ফেরত জান",
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
                        Get.to(AppointmentPage());
                      },
                      child: Text(
                        "পরমর্শ করুন",
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
            itemCount: appointmentDocs.length,
            itemBuilder: (context, index) {
              final appointmentData =
                  appointmentDocs[index].data() as Map<String, dynamic>;
              final date =
                  formateDate((appointmentData['date'] as Timestamp).toDate());
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromARGB(255, 76, 73, 252).withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 120.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue[200],
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  appointmentData['doctorImage'],
                                ))),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "ID: ${appointmentData['id']}",
                                style: TextStyle(
                                    color: HomeColors.textColors,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: 220.w,
                                child: SingleChildScrollView(
                                  child: Text(
                                      "ডাক্তারঃ ${appointmentData['doctor_name']}",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Text(
                                "রোগীর নামেঃ ${appointmentData['patientName']}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 120.w,
                                    child: Text(
                                      "তারিখঃ $date",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    child: Text(
                                      "সময়ঃ ${appointmentData['time']}",
                                      //"3:50 PM",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
