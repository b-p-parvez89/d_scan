import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors/homepage_color.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String subtitle;

  CustomExpansionTile({required this.title, required this.subtitle});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: HomeColors.sectionColor,
        child: ExpansionTile(
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Divider(
            color: HomeColors.textColors,
          ),
          trailing: Icon(_isExpanded
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down),
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },
          children: <Widget>[
            ListTile(
              title: Text(
                widget.subtitle,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
