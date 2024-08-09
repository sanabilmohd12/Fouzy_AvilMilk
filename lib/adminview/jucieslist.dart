import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import 'addjuciecategory.dart';
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            appbarbkgd,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        floatingActionButton: Consumer<Mainprovider>(
            builder: (context, value, child) {
              return FloatingActionButton(
                backgroundColor: cgreen,
                child: Icon(Icons.add, color: cWhite, size: 38),
                onPressed: () {
                  value.getMainCategoy();
                  value.juciecategoryclear();
                  callNext(context, AddJucieCategory(juicefrom: "NEW", jucieoldid: ''));
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
            "Fouzy juices types",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Consumer<Mainprovider>(
                builder: (context, value, child) {
                  return value.getjuciecategoryloader? Center(child: CircularProgressIndicator(color: Colors.green,)):
                  value.juciecategorylist.length>0?
                  ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: value.juciecategorylist.length,
                    itemBuilder: (context, index) {
                      var item = value.juciecategorylist[index];
                      return InkWell(
                        onTap: () {
                          print("kjnkvjnf0"+value.juciecategorylist[index].name);
                          value.getJuiceShakesItems(value.juciecategorylist[index].id);
                          callNext(context, JuciesAndShakesList(
                            jucietypeid: value.juciecategorylist[index].id,
                            jucietypename: value.juciecategorylist[index].name,
                            maincategoryid: value.juciecategorylist[index].maincatoryid,
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          width: width,
                          height: height * .12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: cWhite,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(child: text(item.name, FontWeight.w500, cgreen, 20)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Text("Do you want to DELETE ?",
                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: cBlack)),
                                          actions: <Widget>[
                                            Center(
                                              child: TextButton(
                                                onPressed: () {
                                                  value.deleteJucieCategory(item.id, context);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: myRed,
                                                    borderRadius: BorderRadius.circular(8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x26000000),
                                                        blurRadius: 2.0,
                                                        spreadRadius: 1.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text("Delete",
                                                      style: TextStyle(color: cWhite, fontSize: 17, fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: btn(40, 100, cWhite, "Delete", myRed, FontWeight.w500, 12, Icons.delete_outline),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Text("Do you want to EDIT ?",
                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: cBlack)),
                                          actions: <Widget>[
                                            Center(
                                              child: TextButton(
                                                onPressed: () {
                                                  print("dbjhbd" + item.id);
                                                  value.editJucieCategory(item.id, context);
                                                  callNext(
                                                    context,
                                                    AddJucieCategory(
                                                      juicefrom: "EDIT",
                                                      jucieoldid: item.id,
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: cgreen,
                                                    borderRadius: BorderRadius.circular(8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x26000000),
                                                        blurRadius: 2.0,
                                                        spreadRadius: 1.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text("Edit",
                                                      style: TextStyle(color: cWhite, fontSize: 17, fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: btn(40, 100, cWhite, "Edit", cgreen, FontWeight.w500, 12, Icons.edit_outlined),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                            ],
                          ),
                        ),
                      );
                    },
                  ):Text("The list is empty");
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}