import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/view/homescreen.dart';
import 'package:provider/provider.dart';

import 'adminview/AdminHomeScreen.dart';
import 'provider/mainprovider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        // home: Homescreen(),

      ),
    );
  }
}

