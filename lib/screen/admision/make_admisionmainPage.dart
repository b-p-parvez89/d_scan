// ignore_for_file: unnecessary_null_comparison

import 'package:d_scan/screen/admision/make_admision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors/homepage_color.dart';
import '../appoinyment/help_screen.dart';

class CheckDataPage extends StatefulWidget {
  @override
  _CheckDataPageState createState() => _CheckDataPageState();
}

class _CheckDataPageState extends State<CheckDataPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String patientName = '';
  String paitentId = '';
  String paitentPhone = '';
  String doctor = '';

  String message = '';
  final _formKey = GlobalKey<FormState>();
  // Future<String> checkData({required BuildContext cxt}) async {
  //   try {
  //     final String id = idController.text;
  //     final String phone = phoneController.text;

  //     // Query Firestore for the provided ID and phone number
  //     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('allAppointment')
  //         .where('id', isEqualTo: id)
  //         .where('phone', isEqualTo: phone)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Data found
  //       final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
  //       if (data != null && data['patientName'] != null) {
  //         setState(() {
  //           patientName = data['patientName'].toString();
  //           paitentId = data['id']
  //               .toString(); // Fixed typo: changed 'paitentId' to 'patientId'
  //           paitentPhone = data['phone'];
  //           doctor = data['doctor_name'];
  //           message = 'Data matched!';
  //         });
  //         // Navigate to another page
  //         Get.to(MakeAdmision(
  //           paitentName: patientName,
  //           id: paitentId,
  //           doctor: doctor,
  //           paitenPhone: phone,
  //         ));

  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('সঠিক আইডি ও ফোন!'), // Assuming this is in Bengali
  //           ),
  //         );
  //         return "ধন্যবাদ আপনাকে সঠিক তথ্য দেওয়ার জন্য";
  //       } else {
  //         // Handle null or invalid data
  //         setState(() {
  //           message = 'দয়া করে সঠিক আইডি ও ফোন নাম্বার দিন!';

  //         });

  //         return "'দয়া করে সঠিক আইডি ও ফোন নাম্বার দিন!'";
  //       }
  //     } else {
  //       // Data not found
  //       setState(() {
  //         message = 'দয়া করে সঠিক আইডি ও ফোন নাম্বার দিন!';
  //         patientName = '';
  //       });
  //       return 'দয়া করে সঠিক আইডি ও ফোন নাম্বার দিন!';
  //     }
  //   } catch (e) {
  //     setState(() {
  //       message = 'Error: $e';
  //       patientName = '';
  //     });
  //     return 'Error: $e';
  //   }
  // }

  Future<String> checkData({required BuildContext cxt}) async {
    try {
      final String id = idController.text;
      final String phone = phoneController.text;

      print('ID: $id, Phone: $phone'); // Add this line for debugging

      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('allAppointment')
          .where('id', isEqualTo: id)
          .where('phone', isEqualTo: phone)
          .get();

      print(
          'QuerySnapshot: ${querySnapshot.docs.length} documents found'); // Add this line for debugging

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        if (data != null && data['patientName'] != null) {
          setState(() {
            patientName = data['patientName'].toString();
            paitentId = data['id']
                .toString(); // Fixed typo: changed 'paitentId' to 'patientId'
            paitentPhone = data['phone'];
            doctor = data['doctor_name'];
            message = 'Data matched!';
          });

          // Navigate to MakeAdmision page
          Get.to(MakeAdmision(
            paitentName: patientName,
            id: paitentId,
            doctor: doctor,
            paitenPhone: phone,
          ));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('সঠিক আইডি ও ফোন!'),
            ),
          );
          return "ধন্যবাদ আপনাকে সঠিক তথ্য দেওয়ার জন্য";
        } else {
          setState(() {
            // Handle null or invalid data
          });
          return "'দয়া করে সঠিক আইডি ও ফোন নাম্বার দিন!'";
        }
      } else {
        setState(() {
          // Handle data not found
        });
        return 'দয়া করে সঠিক আইডি ও ফোন নাম্বার দিন!';
      }
    } catch (e) {
      setState(() {
        // Handle error
      });
      return 'Error: $e';
    }
  }

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
            "ভর্তি হন",
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
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight, image: AssetImage(bgImage))),
          ),
          Form(
            key: _formKey,
            child: Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              color: HomeColors.myDoctorHomes,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 290.h,
                  decoration: BoxDecoration(
                      color: HomeColors.sectionColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width / 1.5.w,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: idController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'রোগীর আইডী নাম্বার',
                              labelText: 'রোগীর আইডী নাম্বার'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'দয়াকরে  রোগীর আইডি নাম্বার দিন দিন';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: size.width / 1.5.w,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'ফোন নাম্বার',
                              labelText: 'ফোন নাম্বার'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'দয়াকরে ফোন নাম্বার দিন';
                            }
                            if (value.length != 11) {
                              return 'Phone number must be 11 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CupertinoButton(
                        color: HomeColors.buttonColors,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Validate form fields
                            String? result = await checkData(cxt: context);
                            if (result != null) {
                              // Show SnackBar if data is invalid
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('ডাটা চেক করুন'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
