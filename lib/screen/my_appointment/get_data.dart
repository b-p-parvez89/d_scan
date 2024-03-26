// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// void addAppointment() async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       final userId = currentUser!.uid;

//       // Serialize MyAppointment object into a Map
//       // final Map<String, dynamic> upcommingAppointment = {
//       //   'doctor_name': widget.doctor_name,
//       //   'patientName': widget.paitentName,
//       //   'doctorType': widget.doctorType,
//       //   'doctorImage': widget.doctorImage,
//       //   'date': widget.date,
//       //   'time': widget.time,
//       // };

//       // Get a reference to the user's collection
//       final userCollectionRef =
//           FirebaseFirestore.instance.collection('users').doc(userId);

//       // Post data to Firestore
//       await userCollectionRef
//           .collection('appointments')
//           .get();

//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     content: Text('Appointment posted successfully!'),
//       //   ),
//       // );
//     } catch (e) {
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     content: Text('Failed to post appointment: $e'),
//       //   ),
//       print("object");
      
//     }

// }
