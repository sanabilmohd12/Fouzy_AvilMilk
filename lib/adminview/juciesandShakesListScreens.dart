import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';

import 'addjucies&shakesTypes.dart';


class JuciesAndShakesList extends StatelessWidget {
  String jucietypename;
  String jucietypeid;
  String maincategoryid;
   JuciesAndShakesList({super.key,required this.jucietypename,required this.jucietypeid,required this.maincategoryid});

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
                value.juiceshakesclear();
                value.getJucieCategory();
                callNext(context, addJuciesAndShakes(jucieshakesfrom: "NEW",jucieshakesoldid: '',jucietypename: jucietypename,jucietypeid: jucietypeid, maincategory: maincategoryid,));
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
            " Fouzy special jucies",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:


        SingleChildScrollView(
          child: Column(
            children: [
              Consumer<Mainprovider>(
                builder: (context,value,child) {
                  return value.getjuiceshakeslistloader?Center(child: CircularProgressIndicator(color: Colors.green,)):
                      value.juiceshakesitemslist.length>0?
                  ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: value.juiceshakesitemslist.length,
                    itemBuilder: (context, index) {
                      print("dscde"+value.juiceshakesitemslist[index].price);
                      var data =value.juiceshakesitemslist[index];
                      return Container(
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
                            FittedBox(child: text(data.name, FontWeight.w500, cgreen, 20)),
                            FittedBox(child: text("₹${data.price}", FontWeight.w500, cgreen, 15)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                  value.deletejuiceshakes(data.id, jucietypeid, context);
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
                                    child: btn(40, 100, cWhite, "Delete", myRed, FontWeight.w500, 12,Icons.delete_outline)),

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
                                              value.editjucieshake(data.id,jucietypeid,context);
                                              callNext(
                                                  context,
                                                  addJuciesAndShakes(
                                                    jucieshakesfrom: "EDIT", jucieshakesoldid: data.id, jucietypename: jucietypename, jucietypeid: jucietypename,maincategory: maincategoryid,
                                                  ));
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
                                    child: btn(40, 100, cWhite, "Edit", cgreen, FontWeight.w500, 12,Icons.edit_outlined)),
                              ],
                            ),
                            SizedBox(height: 2,)
                          ],
                        ),

                      );
                    },
                  ):Text("The list is empty");
                }
              ),
            ],
          ),
        ) ,



      ),
    );
  }
}
