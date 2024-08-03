import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/printerProvider.dart';

import 'package:fouzy/view/splashscreen.dart';
import 'package:provider/provider.dart';

import 'adminview/AdminHomeScreen.dart';
import 'provider/mainprovider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAwonLzDyhK4hCYhzOA2d7L4ZUWBWERkZ0",
          appId: "1:374575946310:android:1e04935bf41360d8458847",
          messagingSenderId: "374575946310",
          projectId: "fouzy-381c6",
          storageBucket: "fouzy-381c6.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create:(context) => Mainprovider(),

        ),  ChangeNotifierProvider(create:(context) => PrinterProvider(),

        )

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff033b18)),
          useMaterial3: true,
        ),
        home:  SplashScreen(),
        // home: FouzyMultiple(),
        // home:  Admin_Home_Screen(),
        // home: Home_screen(),
        // home: BottomNavBarV2()
        // home: CategoryScreen(),
      ),
    );
  }
}

