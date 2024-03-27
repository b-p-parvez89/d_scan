import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors/homepage_color.dart';
import '../login/log_in_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _name;
  late String _address;
  late String _phoneNumber;
  late String _email;
  late String _password;

  bool _obscurePassword = true;

  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _obscurePassword = !_obscurePassword;
  //   });
  // }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        final User? user = userCredential.user;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'name': _name,
            'address': _address,
            'phoneNumber': _phoneNumber,
            'email': _email,
            'password':_password
          }).then((value) => Get.to(SignInPage()));

          Get.to(SignInPage());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign up successful!'),
            ),
          );
        }
      } catch (e) {
        print('Error signing up: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign up. Please try again later.'),
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
      child: Stack(children: [
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
                            onSaved: (value) => _name = value!,
                            decoration: InputDecoration(
                              hintText: 'আপনার নাম লিখুন',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'আপনার নাম দিন';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: TextFormField(
                            style: TextStyle(
                                color: HomeColors.textColors,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                            onSaved: (value) => _address = value!,
                            decoration: InputDecoration(
                              hintText: 'ঠিকানা লিখুন',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'আপনার ঠিকানা দিন';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: TextFormField(
                            style: TextStyle(
                                color: HomeColors.textColors,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                            onSaved: (value) => _phoneNumber = value!,
                            decoration: InputDecoration(
                              hintText: 'মোবাইল নাম্বার লিখুন',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'মোবাইল নাম্বার দিন';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: TextFormField(
                            style: TextStyle(
                                color: HomeColors.textColors,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                            onSaved: (value) => _email = value!,
                            decoration: InputDecoration(
                              hintText: 'ইমেইল লিখুন',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'আপনার ইমেইল  দিন';
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
                            onSaved: (value) => _password = value!,
                            decoration: InputDecoration(
                                hintText: "পাসওয়ার্ড লিখুন",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_obscurePassword == true) {
                                          _obscurePassword = false;
                                        } else {
                                          _obscurePassword = true;
                                        }
                                      });
                                    },
                                    icon: _obscurePassword == true
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility))),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'পাসওয়ার্ড দিন';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 32.0),
                        GestureDetector(
                          onTap: () {
                            _signUp();
                          },
                          child: Container(
                            height: 50.h,
                            width: size.width - 60.w,
                            decoration: BoxDecoration(
                                color: HomeColors.buttonColors,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                "রেজিস্টেশন করুন",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: HomeColors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        )
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
                        "রেজিস্টেশন করা থাকলেঃ ",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: HomeColors.appbarTextcolor,
                            fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(SignInPage());
                          },
                          child: Text(
                            "সাইন ইন করুন",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: HomeColors.buttonColors,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                )
              ],
            ))
      ]),
    ));
  }
}
