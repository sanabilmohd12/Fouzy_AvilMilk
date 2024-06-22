import 'package:flutter/material.dart';

import 'homescreen.dart';

class Bottombarom extends StatefulWidget {
  const Bottombarom({super.key});

  @override
  State<Bottombarom> createState() => _BottombaromState();
}

class _BottombaromState extends State<Bottombarom> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int index = 0;
//   // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//   final navigationanKey = GlobalKey<State>();
//
//   final Screen = [
//     Homescreen(),
//     Homescreen(),
//     Homescreen(),
//     Homescreen(),
//   ];
//
//   final items = <Widget>[
//     // Icon(Icons.home_outlined,color: Colors.white,),
//     // Icon(Icons.book,color: Colors.white),
//     // Icon(Icons.book,color: Colors.white),
//
//     Icon(
//       Icons.connecting_airports_sharp,
//       color: Color(0xFFFEF1E2),
//     ),
//     Icon(
//       Icons.connecting_airports_sharp,
//       color: Color(0xFFFEF1E2),
//     ),
//     Icon(
//       Icons.connecting_airports_sharp,
//       color: Color(0xFFFEF1E2),
//     ),
//     Icon(
//       Icons.connecting_airports_sharp,
//       color: Color(0xFFFEF1E2),
//     ),
//
//     // CircleAvatar(backgroundColor: Colors.transparent,radius: 20,backgroundImage: AssetImage("assets/homebutton.png")),
//     // CircleAvatar(backgroundColor: Colors.transparent,radius: 20,backgroundImage: AssetImage("assets/bookingsbutton.png")),
//     // CircleAvatar(backgroundColor: Colors.transparent,radius: 20,backgroundImage: AssetImage("assets/profilebutton.png")),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(label: "sxsx", icon: items[index]),
//             BottomNavigationBarItem(label: "sxsx", icon: items[index]),
//             BottomNavigationBarItem(label: "sxsx", icon: items[index]),
//             BottomNavigationBarItem(label: "sxsx", icon: items[index]),
//           ],
//
//           onTap: (index) => setState(() {
//             this.index = index;
//           }),
//           // buttonBackgroundColor: Colors.white,
//           backgroundColor: Color(0xFF005AFF),
//           selectedItemColor: Colors.red,
//         ),
//         body: Screen[index]);
//   }
// }
