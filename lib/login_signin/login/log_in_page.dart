// ignore_for_file: unused_field, unused_local_variable

import 'package:d_scan/screen/home/homepage.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../sign_up/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _visiblePassword = true;

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _mobileNumberController.text
              .trim(), // Use mobile number for sign-in
          password: _passwordController.text.trim(),
        );

        final User? user = userCredential.user;

        if (user != null) {
          // Navigate to HomePage
          Get.to(HomePage());
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect Phone or Password'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  color: HomeColors.bgColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/photo/bgimage.jpg"))),
            ),
            Container(
              height: size.height,
              width: size.width,
              color: HomeColors.bgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                        color: HomeColors.detailheaderColors,
                        borderRadius: BorderRadius.circular(30.sp)),
                    width: size.width - 50,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "D SCAN HOSPITAL",
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Center(
                            child: TextFormField(
                              style: TextStyle(
                                  color: HomeColors.textColors,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400),
                              controller: _mobileNumberController,
                              decoration: InputDecoration(
                                  hintText: 'ইমেইল অথবা মোবাইল নাম্বার লিখুন',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'মোবাইল নাম্বার অথবা ইমেইল দিন';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: TextFormField(
                              style: TextStyle(
                                  color: HomeColors.textColors,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400),
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  hintText: "পাসওয়ার্ড লিখুন",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _visiblePassword = !_visiblePassword;
                                        });
                                      },
                                      icon: Icon(_visiblePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility))),
                              obscureText: _visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'পাসওয়ার্ড দিন';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 32.0),
                          ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HomeColors.buttonColors,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Container(
                              height: 50.h,
                              width: size.width - 60.w,
                              child: Center(
                                child: Text(
                                  "সাইন ইন করুন",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: HomeColors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "একাউন্ট না থাকলেঃ ",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: HomeColors.appbarTextcolor,
                              fontWeight: FontWeight.w700),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(SignUpPage());
                            },
                            child: Text(
                              "রেজিসটেশন করুন",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: HomeColors.buttonColors,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
