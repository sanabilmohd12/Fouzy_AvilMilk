import 'package:flutter/material.dart';
import 'package:fouzy/view/homescreen.dart';
import 'package:provider/provider.dart';

import 'adminview/AdminHomeScreen.dart';
import 'provider/mainprovider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create:(context) => Mainprovider(),)

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home:  Splashscreen(),
        home:  Admin_Home_Screen(),

      ),
    );
  }
}

