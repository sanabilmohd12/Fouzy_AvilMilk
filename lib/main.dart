import 'package:flutter/material.dart';
import 'package:fouzy/view/homescreen.dart';

import 'adminview/AdminHomeScreen.dart';
import 'adminview/AvilMilkListScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  Splashscreen(),
      // home:  Homescreen(),
      // home: Admin_Home_Screen(),
      home:Avil_Milk_Screen(),


    );
  }
}

