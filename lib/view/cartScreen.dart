import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/constants/custom_icons_icons.dart';
import 'package:fouzy/view/printerScreen.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';

class Cart_Screen extends StatelessWidget {
  const Cart_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: SizedBox(
        height: 65,
        width: width / 1.1,
        child: Consumer<Mainprovider>(builder: (context, value, child) {
          return value.loader
              ? CircularProgressIndicator(
            color: cgreen,
          )
              : FloatingActionButton(
            onPressed: () {
              callNext(context, Printerscreen());
            },
            elevation: 0,
            backgroundColor:cgreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(42),
            ),
            child: text(
              "Save",
              FontWeight.w700,
              cWhite,
              18,
            ),
          );
        }),
      ),
      backgroundColor: cYellow,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appbar bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: ShapeDecoration(
          color: cgreen,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        child: Consumer<Mainprovider>(builder: (context, value, child) {
          if (value.cartItems.isEmpty) {
            return Center(child: Text("Your cart is empty"));
          }
          return value.getloader
              ? Center(
              child: Image.asset(
                "assets/Animation - 1720805331209.json",
                width: 200,
                height: 200,
                fit: BoxFit.fill,

              ))
              : GridView.builder(
            itemCount: value.cartItems.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                childAspectRatio: 1.0
            ),
            itemBuilder: (context, index) {
              String key = value.cartItems.keys.elementAt(index);
              var item = value.cartItems[key];
              List<String> parts = key.split(':');
              String collection = parts[0];
              String firebaseId = parts[1];

              return Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffFFF89A),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: width,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage("assets/Sundae (1).png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                              child: text(item['name'] ?? "NAME", FontWeight.w800, cgreen, 25)
                          ),
                          FittedBox(
                              child: text("₹ ${item['price'] ?? ''}", FontWeight.w700, cgreen, 20)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 55,
                    ),
                    Container(
                      height: height / 19,
                      width: width,
                      color: Color(0xfff9ea1f),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                          ),
                          tileColor: Color(0xfff9ea1f),
                          leading: IconButton(
                              onPressed: () {
                                value.cartItemsControlls(collection, firebaseId, item);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: cWhite,
                                  content: Text("Removed from cart",
                                      style: TextStyle(
                                        color: cgreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      )),
                                  duration: Duration(milliseconds: 3000),
                                ));
                              },
                              icon: const Icon(
                                CustomIcons.minus_circle,
                                color: Colors.red,
                              )
                          ),
                          title: Center(
                            child: text(item['quantity']?.toString() ?? "000", FontWeight.w400, cgreen, 20),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                // Implement quantity increase logic here
                              },
                              icon: Icon(
                                CustomIcons.plus_circle,
                                color: cgreen,
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
