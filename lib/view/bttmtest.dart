import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
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


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MenuScreen(),
      mainScreen: Mainscreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      menuBackgroundColor: cgreen3, // Changed to cYellow
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: cgreen2, // Changed to cYellow
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Consumer<Mainprovider>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    18.0),
                child: IconButton(
                  icon: Icon(Icons.swipe_left,color: clightgold,),
                  onPressed: () => ZoomDrawer.of(context)!.close(),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/ic_launcher.png"),
                    Text("Fouzy AvilMilk",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: clightgold),)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 78.0),
                child: Divider(color: clightgold),
              ), // Changed to cgreen

              Padding(
                padding: EdgeInsets.only(top: 50, left: 50),
                child: ListTile(
                  splashColor: cgreen, // Changed to cgreen

                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(15))),
                  tileColor: Colors.white,
                  leading: Icon(Icons.perm_phone_msg_rounded,color: cgreen,),
                  title: Text('Contact Us',style: TextStyle(fontWeight: FontWeight.bold),),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        title: Center(
                          child: const Text("Contact Developers",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "semibold",
                                color: Colors.white,
                              )),
                        ),
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: cgreen,
                        content: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: height / 4.8,
                            width: width,
                            decoration: BoxDecoration(
                                color: clightgold,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(5.9),
                                    top: Radius.circular(8))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Consumer<Mainprovider>(
                                    builder: (context, value, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          value.makingPhoneCall("+917736310880");
                                        },
                                        child: Container(
                                          height: height / 20.5,
                                          width: width / 1.5,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Colors.blue,
                                                size: 22,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Call Us",
                                                style: TextStyle(
                                                    color: cgreen,
                                                    fontSize: 16,
                                                    fontFamily: "semibold",
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 15,
                                ),
                                Consumer<Mainprovider>(
                                    builder: (context, value, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          value.launchWhatsApp(
                                            phoneNumber:
                                            '+917736310880', // Replace with the target phone number
                                            message: 'Hello',
                                          );
                                        },
                                        child: Container(
                                          height: height / 20.5,
                                          width: width / 1.5,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/icons8-whatsapp-48.png",
                                                scale: 2,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "WhatsApp Us",
                                                style: TextStyle(
                                                    color: cgreen,
                                                    fontSize: 16,
                                                    fontFamily: "semibold",
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, right: 50),
                child: ListTile(
                  splashColor: cgreen, // Changed to cgreen

                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(15))),
                  tileColor: Colors.white,
                  leading: Icon(Icons.contact_support_rounded,color: cgreen,),
                  title: Text('About Us',style: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        title: Center(
                          child: const Text("About Developers",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "semibold",
                                color: Colors.white,
                              )),
                        ),
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: cgreen,
                        content: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: height / 2.8,
                            width: width,
                            decoration: BoxDecoration(
                                color: clightgold,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(5.9),
                                    top: Radius.circular(8))),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 50, left: 50),
                child: ListTile(
                  tileColor: Colors.white,
                  splashColor: cgreen, // Changed to cgreen
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(15))),
                  leading: Icon(
                    Icons.logout_rounded,
                    color: cgreen, // Changed to cgreen
                  ),
                  title: Text(
                    'Exit',
                    style: TextStyle(fontSize:20, color: cgreen), // Changed to cgreen
                  ),
                  onTap: () {
                    showExitPopup(context);
                    // Your logout logic here
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<Mainscreen> {
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

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
      return; // Early return to prevent setState from running
    } else if (tappedIndex == 3) {
      print("here 3");

      provider.fetchOrderList();
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


Future<bool> showExitPopup(BuildContext CONTXT) async {
  return await showDialog(
      context: CONTXT,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cYellow,
          content: SizedBox(
            height: 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to EXIT ?",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'ink nut',
                        fontWeight: FontWeight.w700,
                        color: cgreen)),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style:
                          ElevatedButton.styleFrom(backgroundColor: cgreen),
                          child: Center(
                              child: Text("yes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)))),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Center(
                              child: Text("No",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700))),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
