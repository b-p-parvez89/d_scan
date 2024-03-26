import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home/homepage.dart';

class MakeAdmision extends StatefulWidget {
  final String paitentName;
  final String id;
  final String paitenPhone;
  final String doctor;

  const MakeAdmision({
    Key? key,
    required this.paitentName,
    required this.id,
    required this.paitenPhone,
    required this.doctor,
  }) : super(key: key);

  @override
  State<MakeAdmision> createState() => _MakeAdmisionState();
}

class _MakeAdmisionState extends State<MakeAdmision> {
  String dropdownValue = 'নরমাল ডেলিভারি';
  String oparetion = 'অন্যন্য';

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
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
          "বিবরণ",
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "রোগীর বিবরণ",
                      style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "রোগীর নামঃ",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "রোগীর আইডিঃ",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "মোবাইল নাম্বারঃ",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.paitentName,
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.id,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.paitenPhone,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: TextStyle(color: HomeColors.textColors),
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'অভিভাবকের নাম',
                        border: OutlineInputBorder(),
                        hintText: "অভিভাবকের নাম",
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      style: TextStyle(color: HomeColors.textColors),
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'ঠিকানা',
                        border: OutlineInputBorder(),
                        hintText: "ঠিকানা",
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "কারণঃ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'নরমাল ডেলিভারি',
                            'অন্যন্য',
                            'অপারেশান'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.sp,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    if (dropdownValue == 'অপারেশান')
                      DropdownButton<String>(
                        value: oparetion,
                        onChanged: (String? newValue) {
                          setState(() {
                            oparetion = newValue!;
                          });
                        },
                        items: <String>[
                          'সিজার',
                          'হার্নিয়া',
                          'গল্ডব্লাডার',
                          'এপেন্ডিস',
                          'কিডনির',
                          'অন্যন্য'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'তারিখঃ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: CupertinoButton(
                            color: HomeColors.buttonColors,
                            child: Text(
                              "ভর্তি হন",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              addAdmisionByUser();
                              allAdmision();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('পরমর্শের জন্য অনুরোধ করা হয়েছে'),
                                ),
                              );
                              Get.to(HomePage());
                            }))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void allAdmision() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("allAdmision");
      final Map<String, dynamic> data = {
        'patientName': widget.paitentName,
        'date': selectedDate,
        'id': widget.id,
        'phone': widget.paitenPhone,
        'maincouse': dropdownValue,
        'subcouse': oparetion
      };
      await collectionReference.add(data);
    } catch (e) {}
  }

  void addAdmisionByUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userId = currentUser!.uid;
      final Map<String, dynamic> upcommingAppointment = {
        'patientName': widget.paitentName,
        'date': selectedDate,
        'id': widget.id,
        'phone': widget.paitenPhone,
        'maincouse': dropdownValue,
        'subcouse': oparetion
      };

      // Get a reference to the user's collection
      final userCollectionRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Post data to Firestore
      await userCollectionRef
          .collection('allAdmision')
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
