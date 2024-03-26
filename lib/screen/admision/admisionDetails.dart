// // ignore_for_file: unnecessary_null_comparison

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../utils/colors/homepage_color.dart';

// class AdmisionDetails extends StatelessWidget {
//   final String name;
//   final String id;
//   final DateTime startDate;
//   final String maincouse;
//   final String subcouse;
//   const AdmisionDetails(
//       {super.key,
//       required this.name,
//       required this.id,
//       required this.startDate,
//       required this.maincouse,
//       required this.subcouse});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     String bgImage = "assets/photo/bgimage.jpg";
//     return Scaffold(
//         backgroundColor: HomeColors.bgColor,
//         appBar: AppBar(
//           backgroundColor: HomeColors.appBarbgColor,
//           title: Text(
//             "ভর্তির বিবরণ",
//             style: TextStyle(
//               fontSize: 21.sp,
//               fontWeight: FontWeight.bold,
//               color: HomeColors.appbarTextcolor,
//             ),
//           ),
//           leading: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: Container(
//               padding: EdgeInsets.all(14),
//               child: Image.asset(
//                 "assets/icon/arrowback.png",
//               ),
//             ),
//           ),
//         ),
//         body: Stack(children: [
//           Image.asset(
//             bgImage,
//             height: size.height,
//             width: size.width,
//             fit: BoxFit.cover,
//           ),
//           Container(
//             height: size.height,
//             width: size.width,
//             color: HomeColors.bgColor,
//             child: Column(
//               children: [
//                 Text(
//                   name.toString(),
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 Text(
//                   id.toString(),
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 startDate != null
//                     ? Text(
//                         startDate.toString(),
//                         style: TextStyle(color: Colors.black),
//                       )
//                     : Text(DateTime.now().toString()),
//                 Text(
//                   maincouse,
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 maincouse=='অপারেশান'?Text(
//                   subcouse,
//                   style: TextStyle(color: Colors.black),
//                 ):SizedBox(),
//               ],
//             ),
//           )
//         ]));
//   }
// }
