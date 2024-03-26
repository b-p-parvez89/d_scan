// ignore_for_file: unnecessary_null_comparison, unnecessary_cast

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDoctorsController extends GetxController {
  RxList<Map<String, dynamic>> filteredDoctors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterDoctors('');
  }

  void filterDoctors(String query) {
    if (query.isEmpty) {
      // If query is empty, load all doctors
      FirebaseFirestore.instance
          .collection('all_doctors')
          .get()
          .then((snapshot) {
        List<Map<String, dynamic>> doctorsList = [];
        snapshot.docs.forEach((doc) {
          var data = doc.data();
          if (data != null) {
            // Handle null or missing fields
            doctorsList.add(data as Map<String, dynamic>);
          }
        });
        filteredDoctors.assignAll(doctorsList);
      }).catchError((error) {
        // Handle error
      });
    } else {
      // Query Firestore based on field name
      FirebaseFirestore.instance
          .collection('all_doctors')
          .where('nameByBangla', isGreaterThanOrEqualTo: query)
          .where('nameByBangla',
              isLessThanOrEqualTo: query +
                  '\uf8ff') // Add unicode end character for proper querying
          .get()
          .then((snapshot) {
        List<Map<String, dynamic>> doctorsList = [];
        snapshot.docs.forEach((doc) {
          var data = doc.data();
          if (data != null) {
            // Handle null or missing fields
            doctorsList.add(data as Map<String, dynamic>);
          }
        });
        filteredDoctors.assignAll(doctorsList);
      }).catchError((error) {
        // Handle error
      });

      // Query Firestore for nameByEnglish field
      FirebaseFirestore.instance
          .collection('all_doctors')
          .where('nameByEnglish', isGreaterThanOrEqualTo: query)
          .where('nameByEnglish',
              isLessThanOrEqualTo: query +
                  '\uf8ff') // Add unicode end character for proper querying
          .get()
          .then((snapshot) {
        List<Map<String, dynamic>> englishDoctorsList = [];
        snapshot.docs.forEach((doc) {
          var data = doc.data();
          if (data != null) {
            // Handle null or missing fields
            englishDoctorsList.add(data as Map<String, dynamic>);
          }
        });
        // Merge the result with the existing filteredDoctors list
        filteredDoctors.addAll(englishDoctorsList);
      }).catchError((error) {
        // Handle error
      });

      FirebaseFirestore.instance
          .collection('all_doctors')
          .where('type', isGreaterThanOrEqualTo: query)
          .where('type',
              isLessThanOrEqualTo: query +
                  '\uf8ff') // Add unicode end character for proper querying
          .get()
          .then((snapshot) {
        List<Map<String, dynamic>> englishDoctorsList = [];
        snapshot.docs.forEach((doc) {
          var data = doc.data();
          if (data != null) {
            // Handle null or missing fields
            englishDoctorsList.add(data as Map<String, dynamic>);
          }
        });
        // Merge the result with the existing filteredDoctors list
        filteredDoctors.addAll(englishDoctorsList);
      }).catchError((error) {
        // Handle error
      });
    }
  }
}
