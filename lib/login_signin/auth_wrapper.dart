import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan/login_signin/login/log_in_page.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screen/home/homepage.dart';

import 'sign_up/sign_up_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
              future:
                  _firestore.collection('users').doc(snapshot.data!.uid).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                      body: Stack(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/photo/bgimage.jpg",
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: HomeColors.bgColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/main_logo.png',
                                height: 150.h,
                                width: 150.h,
                              ),
                              Text(
                                "D SCAN HOSPITAL",
                                style: TextStyle(
                                    color: HomeColors.textColors,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ))
                    ],
                  ));
                } else {
                  if (userSnapshot.hasData && userSnapshot.data!.exists) {
                    // User exists in Firestore collection, navigate to home page
                    return HomePage();
                  } else {
                    // User doesn't exist in Firestore collection, navigate to sign-up page
                    return SignUpPage();
                  }
                }
              },
            );
          } else {
            // User is not authenticated, navigate to the sign-in page
            return SignInPage();
          }
        }
      },
    );
  }
}
