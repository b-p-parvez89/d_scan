import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.5),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 200,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
             
            ],
          ),
        ));
  }
}
