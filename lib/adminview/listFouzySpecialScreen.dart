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
import 'addfsp.dart';

class FouzySpecialScreen extends StatelessWidget {
  FouzySpecialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(appbarbkgd),
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
                value.avilmilkclear();
                value.getMainCategoy();
                callNext(
                  context,
                  AddFouzySpecials(
                    fspavilfrom: "NEW",
                    fspaviloldid: "",
                  ),
                );
              },
            );
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
            " Fouzy Special Avil Milks",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<Mainprovider>(
            builder: (context, value, child) {
              return GridView.builder(
                itemCount: value.fspavilmilklist.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.4,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (BuildContext context, int index) {
                  var item = value.fspavilmilklist[index];
                  print("hibaaaaaaaa"+value.fspavilmilklist.length.toString());
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: width,
                    height: height * .12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cWhite,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width,
                          height: 250,
                          child: item.avilphoto.isNotEmpty
                              ? Image.network(
                            item.avilphoto,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading image: $error');
                              return Icon(Icons.error);
                            },
                          )
                              : Icon(Icons.image),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(child: text(item.name, FontWeight.w800, cgreen, 25)),
                              FittedBox(child: text("₹  " + item.price, FontWeight.w700, cgreen, 20)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            FittedBox(child: text(item.describtion, FontWeight.w400, cgreen, 22)),
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
                                    content: Text("Do you want to DELETE ?",
                                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: cBlack)),
                                    actions: <Widget>[
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            value.deleteSpAvilmilk(item.id, context);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: myRed,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x26000000),
                                                  blurRadius: 2.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text("Delete",
                                                  style: TextStyle(color: cWhite, fontSize: 17, fontWeight: FontWeight.w700)),
                                            ),
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
                            SizedBox(width: 40),
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
                                            value.editFSPAvilMilk(item.id, context);
                                            callNext(
                                              context,
                                              AddFouzySpecials(
                                                fspavilfrom: "EDIT",
                                                fspaviloldid: item.id,
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
                                                  style: TextStyle(color: cWhite, fontSize: 17, fontWeight: FontWeight.w700)),
                                            ),
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
                            SizedBox(width: 5),
                          ],
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ),
    );
  }
}