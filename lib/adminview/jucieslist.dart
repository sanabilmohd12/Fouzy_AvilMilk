import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import 'addMainCategory.dart';
import 'addjuciecategory.dart';
import 'addjucies&shakesTypes.dart';
import 'juciesandShakesListScreens.dart';

class jucieslistScreen extends StatelessWidget {
  const jucieslistScreen({super.key});

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
         callNext(context, AddJucieCategory()) ;
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
            "Fouzy jucies types",
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
                return InkWell(onTap: () {
                  callNext(context, JuciesAndShakesList());

                },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: width,
                    height: height*.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cWhite,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(child: text("shakes", FontWeight.w500, cgreen, 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Row(
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
                                                  fontWeight: FontWeight.w600,
                                                  color: cBlack)),
                                          actions: <Widget>[
                                            Center(
                                              child: TextButton(
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
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                    child: btn(20, 60, cWhite, "Delete", myRed, FontWeight.w500, 12,Icons.delete_outline)),

                                InkWell(    onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text(
                                          "Do you want to EDIT ?",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: cBlack)),
                                      actions: <Widget>[
                                        Center(
                                          child: TextButton(
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                    child: btn(20, 60, cWhite, "Edit", cgreen, FontWeight.w500, 12,Icons.edit_outlined)),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 2,)
                      ],
                    ),

                  ),
                );

              },
            ),
          ],
        ) ,


      ),
    );
  }
}
