import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:fouzy/view/salespage.dart';
import 'package:provider/provider.dart';

import '../adminview/AdminHomeScreen.dart';
import '../constants/colors.dart';
import '../loginScreen.dart';
import 'bottombar.dart';
import 'cartScreen.dart';
import 'homescreen.dart';
import 'orderpage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      Home_screen(),
      Cart_Screen(),
      LoginScreen(),
      OrderScreen(),
      SalesScreen(),
    ];
  }

  final items = <Widget>[
    Icon(Icons.home, color: cgreen),
    Icon(Icons.shopping_cart, color: cgreen),
    Icon(CupertinoIcons.cart, color: cYellow),
    Icon(Icons.edit_document, color: cgreen),
    Icon(Icons.auto_graph_outlined, color: cgreen),
  ];

  void handleNavigation(int tappedIndex) {
    Mainprovider provider = Provider.of<Mainprovider>(context, listen: false);

    if (tappedIndex == 0) {
  print("here 0");
      provider.getMainCategoy();
    } else if (tappedIndex == 1) {
      print("here 1");
      provider.getCartItems();
    } else if (tappedIndex == 2) {
      print("here 2");
      provider.clearlogin();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
      return; // Early return to prevent setState from running
    } else if (tappedIndex == 3) {
      print("here 3");
      // Your specific action for index 3
    } else if (tappedIndex == 4) {
      print("here 4");
      DateTime day = DateTime.now();
      DateTime onlyDate = DateTime(day.year, day.month, day.day);
      DateTime endDate2 = onlyDate.add(const Duration(hours: 23, seconds: 59, minutes: 59));
      provider.salesreport(onlyDate, endDate2);
    }
    setState(() {
      index = tappedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        elevation: 90,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        },
        child: Image.asset("assets/Sundae (1).png", scale: 2),
        backgroundColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        items: items,
        index: index,
        height: 75.0,
        onTap: handleNavigation,
        color: cYellow,
        backgroundColor: cgreen,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        letIndexChange: (index) => true,
      ),
      body: screens[index],
    );
  }
}
