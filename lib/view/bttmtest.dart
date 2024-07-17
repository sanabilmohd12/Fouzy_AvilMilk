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

class BottomNavBarV2 extends StatefulWidget {
@override
_BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  final List<Widget> _screens = [
    Home_screen(),
    Cart_Screen(),

    OrderScreen(),
    SalesScreen(),
  ];

  int currentIndex = 0;

  setBottomBarIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Mainprovider provider =Provider.of<Mainprovider>(context,listen: false);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          // Use IndexedStack to keep the state of each screen
          IndexedStack(
            index: currentIndex,
            children: _screens,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 100,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(size.width, 100),
                    painter: BNBCustomPainter(),
                  ),
            InkWell(onTap: () {
              provider.loginCT.clear();
              callNext(context, LoginScreen());
            },
              child: Center(
                        heightFactor: .8,
                        child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(

                image: DecorationImage(
                  scale: 1.7,
                  image: AssetImage('assets/Sundae (1).png'),
                ),
                shape: BoxShape.circle,
                color: cYellow,
                boxShadow: [
                  BoxShadow(color: cgreen, spreadRadius: 5, blurRadius: 10),
                ],
              ),
                        ),
                      ),
            ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.home,
                              color: currentIndex == 0 ? cgreen : Colors.black,
                              size: 30,
                            ),
                            onPressed: () {

                              setBottomBarIndex(0);
                            },
                            splashColor: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: currentIndex == 1 ? cgreen : Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              provider.getCartItems();
                              setBottomBarIndex(1);
                            },
                          ),
                          Container(
                            width: size.width * 0.20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit_document,
                              color: currentIndex == 2 ? cgreen : Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              setBottomBarIndex(2);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.auto_graph_outlined,
                              color: currentIndex == 3 ? cgreen : Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              provider.getJuiceShakesAllItems();
                              setBottomBarIndex(3);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
