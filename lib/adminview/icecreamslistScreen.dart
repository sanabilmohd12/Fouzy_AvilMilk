import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import 'IceCreamandFruitsaladaList.dart';
import 'addicecreamCategory.dart';


class IcrecreamListScreen extends StatelessWidget {
  const IcrecreamListScreen({super.key});

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
        Consumer<Mainprovider>(
          builder: (context,value,child) {
            return FloatingActionButton(
              backgroundColor: cgreen,
              child: Icon(Icons.add, color: cWhite, size: 38),
              onPressed: () {
                value.getMainCategoy();
                value.iceCategoryclear();
                callNext(context, AddIceCreamCategory( icecategoryfrom: "NEW",icecategoryoldid: '',)) ;
              },
            );
          }
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
            "Fouzy IceCream types",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:Column(
          children: [
            Consumer<Mainprovider>(
              builder: (context,value,child) {
                return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: value.icecategorylist.length,
                  itemBuilder: (context, index) {
                    var icedata=value.icecategorylist[index];
                    return InkWell(onTap: () {

                      callNext(context, IceCreamTypesListScreen());

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
                            FittedBox(child: text(icedata.name, FontWeight.w500, cgreen, 20)),
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
                                                      value.deleteicecategory(value.icecategorylist[index].id,context);
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
                                                  print("HBHB"+icedata.id);
                                                  value.editicecategory(value.icecategorylist[index].id, context);
                                                     callNext(context, AddIceCreamCategory(icecategoryfrom: "EDIT", icecategoryoldid:value.icecategorylist[index].id,));
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
                );
              }
            ),
          ],
        ) ,


      ),
    );
  }
}
