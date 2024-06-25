import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            appbarbkgd,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        floatingActionButton:
        FloatingActionButton(
          backgroundColor: cgreen,
          child: Icon(Icons.add, color: cWhite, size: 38),
          onPressed: () {
            callNext(context, addAvilMilkScreen());
          },
        ),

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
            "Main Category",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:Column(
          children: [
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                              "Do you want to  EDIT or DELETE ?",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: cBlack)),
                          actions: <Widget>[
                            Center(
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: myRed,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x26000000),
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
                                                  FontWeight.w700))),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {

                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: cgreen,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x26000000),
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
                                                  FontWeight.w700))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      width: width,
                      height: height*.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: cWhite,
                      ),

                    ));
              },
            ),
          ],
        ) ,


      ),
    );
  }
}
