import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan/screen/home/homepage.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../my_appointment/model_myAppointment.dart';

class CheckboxScreen extends StatefulWidget {
  final String doctor_name;
  final String paitentName;
  final String doctorType;
  final String doctorImage;
  final DateTime date;
  final String time;
  final String id;
  final String phone;

  const CheckboxScreen({
    super.key,
    required this.id,
    required this.doctor_name,
    required this.paitentName,
    required this.phone,
    required this.doctorType,
    required this.doctorImage,
    required this.date,
    required this.time,
  });
  @override
  _CheckboxScreenState createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<CheckboxScreen> {
  bool paymentChecked = true;
  bool withoutPaymentChecked = false;
  MyAppointmentData appointmentData = Get.put(MyAppointmentData());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: paymentChecked,
                    onChanged: (value) {
                      setState(() {
                        paymentChecked = value!;
                        if (value) {
                          withoutPaymentChecked = false;
                        }
                      });
                    },
                  ),
                  Text(
                    'পেমেন্ট করবো',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: withoutPaymentChecked,
                    onChanged: (value) {
                      setState(() {
                        withoutPaymentChecked = value!;
                        if (value) {
                          paymentChecked = false;
                        }
                      });
                    },
                  ),
                  Text(
                    'পরে পেমেন্ট করবো',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (paymentChecked)
          InkWell(
            // onTap: () {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content:
            //         Text("কাজ এখনো সম্পুর্ন হয়নি। খুব শীগ্রই সেবা পাবেন..."),
            //   ));
            // },
            onTap: () {
              if (widget.phone != '') {
                if (widget.paitentName != '') {
                  // addAppointment();
                  // allAppoinment();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('পেমেন্ট এর কাজ চলছে।। কাজ এখনো সম্পুর্ন হয়নি...  '),
                    ),
                  );
                  // Get.to(HomePage());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('অনুগ্রহ করে রোগীর নাম দিন'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('অনুগ্রহ করে মোবাইল নাম্বার দিন'),
                  ),
                );
              }
            },
            child: Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width - 40.w,
              decoration: BoxDecoration(
                  color: HomeColors.buttonColors,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  "পেমেন্ট করুন",
                  style: TextStyle(
                      color: HomeColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        if (withoutPaymentChecked)
          InkWell(
            onTap: () {
              if (widget.phone != '') {
                if (widget.paitentName != '') {
                  addAppointment();
                  allAppoinment();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('পরমর্শের জন্য অনুরোধ করা হয়েছে'),
                    ),
                  );
                  Get.to(HomePage());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('অনুগ্রহ করে রোগীর নাম দিন'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('অনুগ্রহ করে মোবাইল নাম্বার দিন'),
                  ),
                );
              }
            },
            child: Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width - 40.w,
              decoration: BoxDecoration(
                  color: HomeColors.buttonColors,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  "পরমর্শ যোগ করুন",
                  style: TextStyle(
                      color: HomeColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void allAppoinment() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("allAppointment");
      final Map<String, dynamic> data = {
        'doctor_name': widget.doctor_name,
        'patientName': widget.paitentName,
        'doctorType': widget.doctorType,
        'doctorImage': widget.doctorImage,
        'date': widget.date,
        'time': widget.time,
        'id': widget.id,
        'phone': widget.phone
      };
      await collectionReference.add(data);
    } catch (e) {}
  }

  void addAppointment() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userId = currentUser!.uid;
      final Map<String, dynamic> upcommingAppointment = {
        'doctor_name': widget.doctor_name,
        'patientName': widget.paitentName,
        'doctorType': widget.doctorType,
        'doctorImage': widget.doctorImage,
        'date': widget.date,
        'time': widget.time,
        'id': widget.id,
        'phone': widget.phone
      };

      // Get a reference to the user's collection
      final userCollectionRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Post data to Firestore
      await userCollectionRef
          .collection('appointments')
          .add(upcommingAppointment);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('আপনার অনুরোধ গ্রহন করা হয়েক্সহে!'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('অনুরোধ সফল হয়নি অনুগ্রহ করে আবার চেষ্টা করুন'),
        ),
      );
    }
  }
}
