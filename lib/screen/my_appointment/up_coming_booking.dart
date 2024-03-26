import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../appoinyment/appointment_page.dart';

class MyAppointmentsWidget extends StatelessWidget {
  String formateDate(DateTime date) {
    return DateFormat('M/d/y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Return a widget indicating user not logged in
      return Text('User not logged in');
    }

    final userId = currentUser.uid;
    final userCollectionRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    return StreamBuilder<QuerySnapshot>(
      stream: userCollectionRef.collection('appointments').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final appointmentDocs = snapshot.data!.docs;
        if (appointmentDocs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250.h,
                    width: 250.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/icon/sad_imoji.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "আপনার কোনো পরমর্শ বাকি নেই!",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: HomeColors.iconColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "অনুগ্রহ করে পরমর্শ করার জন্য অনুরোধ করুন পরমর্শের জন্য অনুরোধ করতে নিচের বাটন এ ক্লিক করুন অথবা হোম পেজে ফেরত জান",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: HomeColors.iconColor,
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.to(AppointmentPage());
                      },
                      child: Text(
                        "পরমর্শ করুন",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: appointmentDocs.length,
            itemBuilder: (context, index) {
              final appointmentDoc = appointmentDocs[index];
              final appointmentData =
                  appointmentDocs[index].data() as Map<String, dynamic>;
              final date =
                  formateDate((appointmentData['date'] as Timestamp).toDate());
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromARGB(255, 76, 73, 252).withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          height: 135.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue[200],
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    appointmentData['doctorImage'],
                                  ))),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "ID: ${appointmentData['id']}",
                                style: TextStyle(
                                    color: HomeColors.textColors,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: 220.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                      "ডাক্তারঃ ${appointmentData['doctor_name']}",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                width: 220.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    "রোগীর নামেঃ ${appointmentData['patientName']}",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 120.w,
                                    child: Text(
                                      "তারিখঃ $date",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    child: Text(
                                      "সময়ঃ ${appointmentData['time']}",
                                      //"3:50 PM",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      conpleteAppointment(
                                          collectionName: 'completAppointment',
                                          doctor_name:
                                              appointmentData['doctor_name'],
                                          paitentName:
                                              appointmentData['patientName'],
                                          time: appointmentData['time'],
                                          date: appointmentData['date'],
                                          id: appointmentData['id'],
                                          doctorImage:
                                              appointmentData['doctorImage'],
                                          doctorType:
                                              appointmentData['doctorType']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'ডাক্তারের সাথে পরমর্শ করা হয়েছে!'),
                                        ),
                                      );
                                      allAppoinment(
                                          collectionName: 'allComplet',
                                          doctor_name:
                                              appointmentData['doctor_name'],
                                          paitentName:
                                              appointmentData['patientName'],
                                          time: appointmentData['time'],
                                          date: appointmentData['date'],
                                          id: appointmentData['id'],
                                          doctorImage:
                                              appointmentData['doctorImage'],
                                          doctorType:
                                              appointmentData['doctorType']);
                                      _deleteAppointment(
                                          appointmentDoc.reference);
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 90.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.green),
                                      child: Center(
                                        child: Text(
                                          "সম্পুর্ণ হয়েছে",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      conpleteAppointment(
                                          collectionName: 'cencelAppointment',
                                          doctor_name:
                                              appointmentData['doctor_name'],
                                          paitentName:
                                              appointmentData['patientName'],
                                          time: appointmentData['time'],
                                          date: appointmentData['date'],
                                          id: appointmentData['id'],
                                          doctorImage:
                                              appointmentData['doctorImage'],
                                          doctorType:
                                              appointmentData['doctorType']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'ডাক্তারের সাথে পরমর্শ বাতিল করা হয়েছে!'),
                                        ),
                                      );
                                      allAppoinment(
                                          collectionName: 'allCancel',
                                          doctor_name:
                                              appointmentData['doctor_name'],
                                          paitentName:
                                              appointmentData['patientName'],
                                          time: appointmentData['time'],
                                          date: appointmentData['date'],
                                          id: appointmentData['id'],
                                          doctorImage:
                                              appointmentData['doctorImage'],
                                          doctorType:
                                              appointmentData['doctorType']);
                                      _deleteAppointment(
                                          appointmentDoc.reference);
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.red),
                                      child: Center(
                                        child: Text(
                                          "বাতিল করুন",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<void> _deleteAppointment(DocumentReference appointmentRef) async {
    try {
      await appointmentRef.delete();
      print('Appointment deleted successfully');
    } catch (e) {
      print('Failed to delete appointment: $e');
    }
  }

  void conpleteAppointment(
      {var doctor_name,
      paitentName,
      doctorType,
      doctorImage,
      date,
      time,
      id,
      collectionName}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userId = currentUser!.uid;

      // Serialize MyAppointment object into a Map
      final Map<String, dynamic> upcommingAppointment = {
        'doctor_name': doctor_name,
        'patientName': paitentName,
        'doctorType': doctorType,
        'doctorImage': doctorImage,
        'date': date,
        'time': time,
        'id': id
      };

      // Get a reference to the user's collection
      final userCollectionRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Post data to Firestore
      await userCollectionRef
          .collection(collectionName)
          .add(upcommingAppointment);
    } catch (e) {}
  }

  void allAppoinment(
      {var doctor_name,
      paitentName,
      doctorType,
      doctorImage,
      date,
      time,
      id,
      collectionName}) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(collectionName);
      final Map<String, dynamic> data = {
        'doctor_name': doctor_name,
        'patientName': paitentName,
        'doctorType': doctorType,
        'doctorImage': doctorImage,
        'date': date,
        'time': time,
        'id': id
      };
      await collectionReference.add(data);
    } catch (e) {}
  }
}
