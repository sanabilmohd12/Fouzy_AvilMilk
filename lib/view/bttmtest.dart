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

// class BottomNavBarV2 extends StatefulWidget {
// @override
// _BottomNavBarV2State createState() => _BottomNavBarV2State();
// }
//
// class _BottomNavBarV2State extends State<BottomNavBarV2> {
//   final List<Widget> _screens = [
//     Home_screen(),
//     Cart_Screen(),
//     LoginScreen(),
//     OrderScreen(),
//     SalesScreen(),
//   ];
//
//   int currentIndex = 0;
//
//   setBottomBarIndex(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     Mainprovider provider =Provider.of<Mainprovider>(context,listen: false);
//
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white.withAlpha(55),
//       body: Stack(
//         children: [
//           // Use IndexedStack to keep the state of each screen
//           IndexedStack(
//             index: currentIndex,
//             children: _screens,
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: Container(
//               width: size.width,
//               height: 100,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   CustomPaint(
//                     size: Size(size.width, 100),
//                     painter: BNBCustomPainter(),
//                   ),
//             GestureDetector(onTap: () {
//               provider.loginCT.clear();
//               callNext(context, LoginScreen());
//             },
//               child: Center(
//                         heightFactor: .8,
//                         child: Container(
//               height: 80,
//               width: 80,
//
//               decoration: BoxDecoration(
//
//
//
//                 image: DecorationImage(
//                   scale: 1.7,
//                   image: AssetImage('assets/Sundae (1).png'),
//                 ),
//                 shape: BoxShape.circle,
//                 color: cYellow,
//                 boxShadow: [
//                   BoxShadow(color: cgreen, spreadRadius: 5, blurRadius: 10),
//                 ],
//               ),
//                         ),
//                       ),
//             ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 18.0),
//                     child: Container(
//                       // color: Colors.orange,
//                       width: size.width,
//                       height: 80,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               Icons.home,
//                               color: currentIndex == 0 ? Colors.white : cgreen,
//                               size: 30,
//                             ),
//                             onPressed: () {
//                               provider.getMainCategoy();
//                               print("ffvfvfv" +
//
//                                   provider.mainCategorylist.length.toString());
//                               setBottomBarIndex(0);
//                             },
//                             splashColor: Colors.white,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.shopping_cart,
//                               color: currentIndex == 1 ? Colors.white : cgreen,
//                               size: 30,
//                             ),
//                             onPressed: () {
//
//                               provider.getCartItems();
//                               provider.cusdetailsclear();
//
//                               setBottomBarIndex(1);
//                             },
//                           ),
//                           Container(
//                             width: size.width * 0.20,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.edit_document,
//                               color: currentIndex == 2 ? Colors.white : cgreen,
//                               size: 30,
//                             ),
//                             onPressed: () {
//                               DateTime day = DateTime.now();
//                               DateTime onlyDate = DateTime(day.year, day.month, day.day);
//                               DateTime endDate2 = onlyDate.add(const Duration(hours: 23, seconds: 59, minutes: 59));
//                               print("nkjdaksmd");
//                               // provider.getordereddetils();
//                               provider.fetchOrderList(onlyDate,endDate2);
//                               print("fsfs"+provider.orderList.length.toString());
//                               setBottomBarIndex(2);
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.auto_graph_outlined,
//                               color: currentIndex == 3 ? Colors.white : cgreen,
//                               size: 30,
//                             ),
//                             onPressed: () {
//
//                               setBottomBarIndex(3);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  late final List<Widget> screens;

  @override
  void initState() {
    Mainprovider provider = Provider.of<Mainprovider>(context, listen: false);

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
    if (tappedIndex == 2) {
      // Navigate to a new screen
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    } else {
      setState(() {
        index = tappedIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(elevation: 90,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        },
        child: Image.asset("assets/Sundae (1).png",scale: 2,),
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
      body: index < screens.length ? screens[index] : Container(),
    );
  }
}
