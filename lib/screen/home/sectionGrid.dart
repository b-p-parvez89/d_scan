// ignore_for_file: deprecated_member_use

import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/data/home_page_data.dart';

class SectionGride extends StatefulWidget {
  const SectionGride({super.key});

  @override
  State<SectionGride> createState() => _SectionGrideState();
}

class _SectionGrideState extends State<SectionGride> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomepageData data = Get.put(HomepageData());
    return Container(
      height: 500,
      width: double.infinity,
      child: GridView.builder(
        itemCount: 10,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var _data = data.homeData[index];
          return GestureDetector(
            onTap: () async {
              _data['pages'] == null
                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "কাজ এখনো সম্পুর্ন হয়নি। খুব শীগ্রই সেবা পাবেন..."),
                    ))
                  : Get.to(_data["pages"]);
              // final url = Uri.parse(_data['web']);
              if (_data['web'] != null) {
                await launchUrl(Uri.parse(_data['web']));
              }
            },
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isHovered = false;
                });
              },
              child: Container(
                height: 100.h,
                width: size.width / 2.w,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo),
                    color: HomeColors.sectionColor),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _data["icon"],
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _data['text'],
                        style: TextStyle(
                            color: HomeColors.iconColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
