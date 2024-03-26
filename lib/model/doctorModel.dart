import 'package:get/get.dart';

class DoctorModel {
  final String nameByEnglish;
  final String nameByBangla;
  final String type;
  final String degree;
  final List day;
  final List times;

  DoctorModel({
    required this.nameByEnglish,
    required this.nameByBangla,
    required this.type,
    required this.degree,
    required this.day,
    required this.times
  });
}

class MyDoctors extends GetxController {
  RxList doctors = [
    DoctorModel(
        nameByEnglish: "Dr. Fabeya Rahmana",
        nameByBangla: "ডাঃ ফাবেয়া রহমান",
        type: "গাইনী ও সার্জন, মা ও শিশু বিশেষজ্ঞ",
        degree: "এম বি বি এস",
        day: [],
        times:[]),
        DoctorModel(
        nameByEnglish: "Dr. Ali Fazor Lal",
        nameByBangla: "ডাঃ আলী ফজল লাল",
        type: "হাড় জোড় ও বাত ব্যাথা ",
        degree: "এম বি বি এস",
        day: [],
        times:[]),
        DoctorModel(
        nameByEnglish: "Dr. Aminul Ismal",
        nameByBangla: "ডাঃ আমিনুল ইসলাম",
        type: "নাক কান গলা",
        degree: "এম বি বি এস",
        day: [], 
        times:[]),

  ].obs;
}
