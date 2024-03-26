import 'package:get/get.dart';

class MyAppointment {
  final String doctor_name;
  final String paitentName;
  final String doctorType;
  final String doctorImage;
  final DateTime date;
  final String time;
  final bool onlinePay;

  MyAppointment(
      {required this.doctor_name,
      required this.paitentName,
      required this.doctorType,
      required this.doctorImage,
      required this.date,
      required this.time,
      required this.onlinePay});
}


class MyUpcommingAppointment {
  final String doctor_name;
  final String paitentName;
  final String doctorType;
  final String doctorImage;
  final DateTime date;
  final String time;
  final bool onlinePay;

  MyUpcommingAppointment({
    required this.doctor_name,
    required this.paitentName,
    required this.doctorType,
    required this.doctorImage,
    required this.date,
    required this.time,
    required this.onlinePay,
  });

  // Convert MyAppointment instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'doctor_name': doctor_name,
      'paitentName': paitentName,
      'doctorType': doctorType,
      'doctorImage': doctorImage,
      'date': date,
      'time': time,
      'onlinePay': onlinePay,
    };
  }
}

class MyAppointmentData extends GetxController {
  RxList upcoming=[
   
  ].obs;
  RxList cancelledData = [
    MyAppointment(
        doctor_name: "Dr. Md Rana",
        paitentName: "Md Sagor",
        doctorType: "Medicin Specialist",
        doctorImage: "image/jpg",
        date: DateTime.now(),
        time: "2:30",
        onlinePay: false)
  ].obs;

  RxList completed = [
    // MyAppointment(
    //     doctor_name: "Dr. Md Rana",
    //     paitentName: "Md Selim",
    //     doctorType: "Medicin Specialist",
    //     doctorImage: "image/jpg",
    //     date: DateTime.now(),
    //     time: "2:40",
    //     onlinePay: false)
  ].obs;
}
