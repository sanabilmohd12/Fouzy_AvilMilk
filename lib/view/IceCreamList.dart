import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';
import 'cartScreen.dart';

class IceCreamListScreen extends StatelessWidget {
  const IceCreamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Mainprovider provider = Provider.of<Mainprovider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getavilmilktypes();
    });

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final int index1;
    return Scaffold(
        backgroundColor: cYellow,
        floatingActionButton:
            Consumer<Mainprovider>(builder: (context, value, child) {
          bool isAnySelected = false;
          for (int i = 0; i < value.avilmilklist.length; i++) {
            if (value.getCheckboxValue(i) == true) {
              isAnySelected = true;
              break;
            }
          }
          return isAnySelected
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.yellow,
                  onPressed: () {
                    callNext(context, Cart_Screen());
                  },
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  icon: Icon(Icons.shopping_cart, color: cgreen),
                )
              : SizedBox();
        }),
        appBar: AppBar(
          title: const Text(
            "FOUZY ICE CREAMS",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgimg.jpeg'),
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
            return value.getloader
                ? Center(
                    child: CircularProgressIndicator(
                      color: cgreen,
                    ),
                  )
                : Consumer<Mainprovider>(builder: (context, value, child) {
                    return GridView.builder(
                      itemCount: value.icecreamlist.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          crossAxisCount: 2,
                          childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        var items = value.icecreamlist[index];
                        return GestureDetector(
                          onTap: (){
                            value.setCheckboxValue(index, !value.getCheckboxValue(index));

                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: 200,
                              height: height * .12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: cYellow,
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width,

                                      // decoration: BoxDecoration(
                                      //     color: Colors.transparent,
                                      //     image: DecorationImage(
                                      //         image: item.avilphoto != ""
                                      //             ? NetworkImage(
                                      //           item.avilphoto,
                                      //         )
                                      //             : AssetImage(""))),
                                      child: Consumer<Mainprovider>(
                                          builder: (context, value, child) {
                                        return Align(
                                            alignment: Alignment.topRight,
                                            child: Transform.scale(
                                              scale: 1.5,
                                              child: Checkbox(
                                                shape: CircleBorder(),
                                                value:
                                                    value.getCheckboxValue(index),
                                                onChanged: (bool? newValue) {
                                                  value.setCheckboxValue(
                                                      index, newValue ?? false);
                                                },
                                                checkColor: Colors.green,
                                                fillColor: WidgetStatePropertyAll(
                                                    Colors.white),
                                              ),
                                            ));
                                      }),
                                    ),
                                    FittedBox(
                                        child: text(items.icecreamfalovour,
                                            FontWeight.w800, cgreen, 25)),
                                    FittedBox(
                                        child: text("₹  " + items.singleprice,
                                            FontWeight.w700, cgreen, 20)),
                                    FittedBox(
                                        child: text("₹  " + items.doubleprice,
                                            FontWeight.w700, cgreen, 20)),
                                  ])),
                        );
                      },
                    );

                    //
                  });
          }),
        ));
  }
}
