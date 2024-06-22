import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: double.infinity,
          decoration: const  BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/fouzy splash .jpg',
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'FOUZY AVIL MILK',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff119246),
                  ),
                ),
              ),
              Image.asset('assets/fouzylogo.png',scale: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
