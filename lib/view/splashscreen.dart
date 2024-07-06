

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/callFunctions.dart';
import '../provider/mainprovider.dart';
import 'bottombar.dart';
import 'bttmtest.dart';
import 'homescreen.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    print("codee id her");

    Timer? _timer;


    super.initState();

    Mainprovider mainProvider = Provider.of<Mainprovider>(context, listen: false);



    Timer(const Duration(seconds: 3), () {
      mainProvider.getMainCategoy();
      callNext(context,  BottomNavBarV2()
      );
    });

  }



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
