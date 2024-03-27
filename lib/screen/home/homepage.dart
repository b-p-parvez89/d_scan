import 'package:d_scan/screen/home/drawer.dart';
import 'package:d_scan/screen/home/sectionGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors/homepage_color.dart';
import '../../widgets/image_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String bgImage = "assets/photo/bgimage.jpg";

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: HomeColors.appBarbgColor,
        title: Text(
          "D SCAN HOSPITAL",
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: HomeColors.appbarTextcolor),
        ),
        iconTheme: IconThemeData(color: HomeColors.iconColor),
        actions: [
          IconButton(
            onPressed: () async {
              final url = 'tel:8801797709709';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: Icon(
              Icons.add_ic_call,
              size: 32,
              color: HomeColors.iconColor,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor: HomeColors.bgColor,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ImageSlider(),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 3,
                      color: Colors.blue,
                    ),
                    SectionGride(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
