import 'package:d_scan/login_signin/login/log_in_page.dart';
import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _name = '';
  String _phoneNumber = '';
  String _email = '';
  String _address = '';
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          _name = userData['name'];
          _phoneNumber = userData['phoneNumber'];
          _email = userData['email'];
          _address = userData['address'];
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      Get.to(SignInPage());
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueAccent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPictureSize: Size.square(56),
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.person,
                size: 54.sp,
              ),
            ),
            accountName: _isLoading || _hasError
                ? Text('Loading...')
                : Text(
                    _name,
                    style: TextStyle(
                        color: HomeColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp),
                  ),
            accountEmail: _isLoading || _hasError
                ? Text('')
                : Text(
                    _email,
                    style: TextStyle(
                        color: HomeColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _hasError
                  ? ListTile(
                      title: Text('Error fetching user data'),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height - 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number: $_phoneNumber',
                                  style: TextStyle(
                                      color: HomeColors.textColors,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Text(
                                  'Address: $_address',
                                  style: TextStyle(
                                      color: HomeColors.textColors,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Log Out",
                                      style: TextStyle(
                                          color: HomeColors.textColors,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    IconButton(
                                        onPressed: _logout,
                                        icon: Icon(
                                          Icons.logout,
                                          color: Colors.black,
                                          weight: 500,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Developed by",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      final url = 'tel:8801313561457';
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      "Md Parvez Ali 📞",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}
