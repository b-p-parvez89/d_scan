// ignore_for_file: unused_label, unused_field, unused_local_variable, unnecessary_null_comparison

import 'dart:math';
import 'package:d_scan/screen/home/homepage.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

import 'check_payment_widget.dart';

class ConfrimedAppoinment extends StatefulWidget {
  final String doctorname;
  final String type;
  final String degree;
  final String image;
  final List day;
  final List time;
  const ConfrimedAppoinment(
      {super.key,
      required this.day,
      required this.time,
      required this.image,
      required this.doctorname,
      required this.type,
      required this.degree});

  @override
  State<ConfrimedAppoinment> createState() => _ConfrimedAppoinmentState();
}

class _ConfrimedAppoinmentState extends State<ConfrimedAppoinment> {
  String _selectedTime = '';

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEE, M/d/y').format(date);
  }

  late List<dynamic> selectableDays = widget.day;
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    DateTime nextSelectableDate = DateTime.now();
    while (!selectableDays
        .contains(DateFormat('EEEE').format(nextSelectableDate))) {
      nextSelectableDate = nextSelectableDate.add(Duration(days: 1));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: nextSelectableDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      selectableDayPredicate: (DateTime date) {
        return selectableDays.contains(DateFormat('EEEE').format(date));
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String paitenName = '';
  String mobilNumber = '';
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    generateUniqueId(12);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 14, 73),
        actions: [
          TextButton(
              onPressed: () {
                Get.to(HomePage());
              },
              child: Text(
                "হোম",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: HomeColors.appbarTextcolor,
                ),
              ))
        ],
        title: Text(
          "ডাক্তার পরিচিত",
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
      backgroundColor: HomeColors.detailheaderColors,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 360.h,
                    width: double.infinity,
                    color: HomeColors.detailheaderColors,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: HomeColors.detailsPageBottomColors,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Lottie.asset('assets/icon/ok.json',
                          animate: true, height: 100.h, width: 100.w),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "পরমর্শ করার জন্য সামনে এগিয়ে যান",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Container(
                    height: 430.h,
                    padding: EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 76, 73, 252).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "আইডি নং:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SelectableText(
                              paitenId,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          height: 100.h,
                          child: Row(
                            children: [
                              Container(
                                height: 100.h,
                                width: 105.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(widget.image),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(12),
                                    color: HomeColors.detailheaderColors),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.doctorname,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 175.w,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.degree,
                                        style: TextStyle(
                                            color: HomeColors.subtextColors,
                                            fontSize: 13.sp),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 175.w,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.type,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "রোগীর নামেঃ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
                            ),
                            Container(
                              width: 170.w,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    paitenName = value;
                                  });
                                },
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'রোগীর নাম লিখুন',
                                    hintStyle: TextStyle(fontSize: 14.sp)),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "মোবাইল নাম্বারঃ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
                            ),
                            Container(
                              width: 170.w,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    mobilNumber = value;
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'মোবাইল নাম্বার লিখুন',
                                    hintStyle: TextStyle(fontSize: 14.sp)),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "তারিখঃ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                            Container(
                              //width: 180.w,
                              child: TextButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                    selectedDate == null
                                        ? "তারিখ নির্বাচন করুণ"
                                        : "${_formatDate(selectedDate)}",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black),
                                  )),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "সময়: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                            Container(
                              width: 200.w,
                              child: TextField(
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'সময় নির্বাচন করুন',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                onTap: () async {
                                  final selectedTime = await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'সময় নির্বাচন করুন',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: widget.time
                                                .map(
                                                  (time) => ListTile(
                                                    title: Text(time),
                                                    onTap: () {
                                                      Navigator.pop(
                                                          context, time);
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  if (selectedTime != null) {
                                    _selectTime(selectedTime);
                                  }
                                },
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _selectedTime,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: CheckboxScreen(
                        doctorImage: widget.image,
                        phone: mobilNumber,
                        time: _selectedTime,
                        date: selectedDate,
                        doctor_name: widget.doctorname,
                        paitentName: paitenName,
                        doctorType: widget.type,
                        id: paitenId,
                      )))
            ],
          ),
        ),
      ),
    );
  }

  late String paitenId;
  void generateUniqueId(int index) {
    const chars = 'ABCD0123456789';
    final random = Random();
    int length = (index ~/ 14) + 10;

    String id = '';
    for (int i = 0; i < length; i++) {
      id += chars[random.nextInt(chars.length)];
    }

    paitenId = id;
  }
}
