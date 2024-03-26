// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:d_scan/utils/colors/homepage_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'screen/home/homepage.dart';

// class CustomExpansionTile extends StatefulWidget {
//   final String title;
//   final String subtitle;

//   CustomExpansionTile({required this.title, required this.subtitle});

//   @override
//   _CustomExpansionTileState createState() => _CustomExpansionTileState();
// }

// class _CustomExpansionTileState extends State<CustomExpansionTile> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: HomeColors.sectionColor,
//       child: ExpansionTile(
//         title: Text(
//           widget.title,
//           style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.black,
//               fontWeight: FontWeight.bold),
//         ),
//         trailing: Icon(
//             _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
//         onExpansionChanged: (value) {
//           setState(() {
//             _isExpanded = value;
//           });
//         },
//         children: <Widget>[
//           ListTile(
//             title: Text(
//               widget.subtitle,
//               style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Servises extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     String bgImage = "assets/photo/bgimage.jpg";
//     return Scaffold(
//         backgroundColor: HomeColors.bgColor,
//         appBar: AppBar(
//           backgroundColor: HomeColors.appBarbgColor,
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.to(HomePage());
//               },
//               child: Text(
//                 "হোম",
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//           title: Text(
//             "আমাদের সেবা",
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
//             color: HomeColors.myDoctorHomes,
//             child: StreamBuilder(
//               stream:
//                   FirebaseFirestore.instance.collection('service').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 } else {
//                   return ListView(
//                     children:
//                         snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data =
//                           document.data() as Map<String, dynamic>;
//                       return CustomExpansionTile(
//                         title: data['title'],
//                         subtitle: data['subtitle'],
//                       );
//                     }).toList(),
//                   );
//                 }
//               },
//             ),
//           )
//         ]));
//   }
// }
