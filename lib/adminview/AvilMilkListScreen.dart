import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import 'addAvilMilk.dart';

class Avil_Milk_Screen extends StatelessWidget {
  const Avil_Milk_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            appbarbkgd,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        floatingActionButton:
            Consumer<Mainprovider>(builder: (context, value, child) {
          return FloatingActionButton(
            backgroundColor: cgreen,
            child: Icon(Icons.add, color: cWhite, size: 38),
            onPressed: () {
              value.avilmilkclear();
              value.getMainCategoy();
              callNext(
                  context,
                  addAvilMilkScreen(
                    avilfrom: "NEW",
                    aviloldid: "",
                  ));
            },
          );
        }),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              back(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: cgreen,
              size: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: text(
            " Fouzy Avil Milks",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<Mainprovider>(builder: (context, value, child) {
            return
                 GridView.builder(
                    itemCount: value.avilmilklist.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0.5,
                        mainAxisSpacing: 0.4,
                        childAspectRatio: 0.6),
                    itemBuilder: (BuildContext context, int index) {
                      var item = value.avilmilklist[index];
                      return value.getavilloader
                          ? Center(
                              child: Lottie.asset(
                                'assets/mixer-lottie.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: width / 100, vertical: 5),
                              width: width,
                              height: height * .12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: cWhite,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: width,
                                      height: 250,
                                      child: item.avilphoto != ""
                                          ? Image(
                                              image: NetworkImage(
                                                  item.avilphoto,
                                                  scale: 0.5),
                                            )
                                          : SizedBox()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * .001),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FittedBox(
                                            child: text(
                                                item.name,
                                                FontWeight.w800,
                                                cgreen,
                                                item.name.length < 18
                                                    ? 18
                                                    : 14)),
                                        FittedBox(
                                            child: text("₹  " + item.price,
                                                FontWeight.w700, cgreen, 20)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      FittedBox(
                                          child: text(item.describtion,
                                              FontWeight.w400, cgreen, 22)),
                                    ],
                                  ),
                                  SizedBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                  "Do you want to DELETE ?",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: cBlack)),
                                              actions: <Widget>[
                                                Center(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      value.deleteavilmilk(
                                                          item.id, context);

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                          color: myRed,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0x26000000),
                                                              blurRadius:
                                                                  2.0, // soften the shadow
                                                              spreadRadius:
                                                                  1.0, //extend the shadow
                                                            ),
                                                          ]),
                                                      child: Center(
                                                          child: Text("Delete",
                                                              style: TextStyle(
                                                                  color: cWhite,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700))),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          size: 30,
                                          color: myRed,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                  "Do you want to EDIT ?",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: cBlack)),
                                              actions: <Widget>[
                                                Center(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      print("editttttt" +
                                                          item.id);
                                                      value.editavilmilk(
                                                          item.id, context);
                                                      callNext(
                                                          context,
                                                          addAvilMilkScreen(
                                                            avilfrom: "EDIT",
                                                            aviloldid: item.id,
                                                          ));
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                          color: cgreen,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0x26000000),
                                                              blurRadius:
                                                                  2.0, // soften the shadow
                                                              spreadRadius:
                                                                  1.0, //extend the shadow
                                                            ),
                                                          ]),
                                                      child: Center(
                                                          child: Text("Edit",
                                                              style: TextStyle(
                                                                  color: cWhite,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700))),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.edit_outlined,
                                          size: 30,
                                          color: cgreen,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  )
                                ],
                              ),
                            );
                    });
          }),
        ),
      ),
    );
  }
}
