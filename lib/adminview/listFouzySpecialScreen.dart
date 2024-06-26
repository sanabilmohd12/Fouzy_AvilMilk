import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import 'addMainCategory.dart';
import 'addjuciecategory.dart';
import 'addjucies&shakesTypes.dart';

class FouzySpecialScreen extends StatelessWidget {
  const FouzySpecialScreen({super.key});

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
            "Fouzy Special",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8
                  ),
                  itemBuilder: (BuildContext context,int index){
                    return  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      width: width,
                      height: height*.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: cWhite,
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SizedBox(width: width,height: 60,
                            child: Image(image: AssetImage(juciepic,),)),
                        FittedBox(child: text("named", FontWeight.w400, cgreen, 15)),
                        FittedBox(child: text("15", FontWeight.w400, cgreen, 15)),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Padding(
                                padding: const EdgeInsets.only(right: 5,top: 5),
                                child: InkWell( onTap:  () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text(
                                          "Do you want to add Fouzy Special",
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
                                                      child: Text("Remove",
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
                                                      child: Text("Add",
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
                                    child: CircleAvatar(radius: 12,child: Icon(Icons.add,))),
                              ),

                            ],
                          )
                      ],),

                    );

                  })

            ],
          ),
        ) ,


      ),
    );
  }
}
