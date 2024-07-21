import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../constants/myimages.dart';

class Printerscreen extends StatelessWidget {
  String name;
  String deskno;
  String ordertype;
  String datetime;
   Printerscreen({super.key,required this.name,required this.deskno,required this.ordertype,required this.datetime});

  @override
  Widget build(BuildContext context) {
    print(deskno+"dcvfvfvfv"+name+"kgfcvbn"+ordertype+"uytrfcvbnm"+datetime);
    ScreenshotController screenshotController = ScreenshotController();

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
        body:  SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                child: Container(
                  // height: height / 15,
                  width: width,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9), color: cgreen),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text(
                          "Invoice",
                          style: TextStyle(
                              fontSize: 31,
                              color: cYellow),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 7),
                        child: Image(
                          image: AssetImage(
                              "assets/Sundae (1).png"

                          ),
                          height: 40,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Screenshot(
                controller: screenshotController,
                child: Container(
                  color: cWhite,
                  child: Column(

                    children: [
                      SizedBox(height: 20,),

                      CircleAvatar(radius: 50,
                          backgroundImage: AssetImage(
                            'assets/fouzylogo.png',
                          ),),
                      Text(
                        'FOUZY AVIL MILK',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff119246),
                        ),
                      ),  Text(
                        'ELAYUR,KOOTTAVIL ROAD,PARAMMAL,KAVANUR',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:cBlack ,
                        ),
                      ),
                      Text(
                        'ELAYUR',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:cBlack ,
                        ),
                      ),
                      // Text(
                      //   'PH : 7894561236',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400,
                      //     color:cBlack ,
                      //   ),
                      // ),
                        Text("----------------------------------------------------------------------------------------------------------------------------"),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        width: width,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name :"+name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:cBlack ,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date :"+datetime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:cBlack ,
                                  ),
                                ),  Text(
                                  "Table No :"+deskno,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:cBlack ,
                                  ),
                                ),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Oder Mode : '+ordertype,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:cBlack ,
                                  ),
                                ),
                                Consumer<Mainprovider>(
                                  builder: (context,value,child) {
                                    return Text(
                                      'Inv No: 000'+value.orderCount.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:cBlack ,
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),




                        Text("----------------------------------------------------------------------------------------------------------------------------"),


                      const SizedBox(height: 10),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 25),


                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 25,
                                height: 50,

                                child: Text(
                                  "SI\nNO",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,

                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                ),
                              ),

                              SizedBox(
                                width: 250,
                                height: 50,

                                child: Text(
                                  "Items",textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 50,

                                child: Text(
                                  "Qty",textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),


                              SizedBox(
                                width: 80,
                                height: 50,

                                child: Text(
                                  "Rate",textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),

                              SizedBox(
                                width: 80,
                                height: 50,

                                child: Text(
                                  "Total",textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),
                            ]),
                      ),




                      const SizedBox(height: 10),
                      Container(width: width / 1.1, height: 1, color: Colors.black),
                      const SizedBox(height: 10),
                      Consumer<Mainprovider>(
                        builder: (context,value,child) {
                          return ListView.builder(

                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.cartitemslist.length,
                            itemBuilder: (context, index) {
                              var items =value.cartitemslist[index];
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                width: width,
                                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                                  children: [
                                    SizedBox(
                                      width: 25,

                                      child: Text(
                                        "${index+1}",textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    // SizedBox(width: width / 22),
                                    SizedBox(
                                      width: 250,

                                      child: Text(
                                       items.itemname,textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    // SizedBox(width: width / 3.1),
                                    SizedBox(
                                      width: 80,

                                      child: Text(items.count.toString()
                                        ,textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    // SizedBox(width: width / 8),
                                    SizedBox(
                                      width: 80,

                                      child: Text(
                                        items.itemprice,textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,

                                      child: Text(
                                        items.itemprice,textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },);
                        }
                      ),

                      const SizedBox(height:60),
                      Consumer<Mainprovider>(
                        builder: (context,value,child) {
                          // double Sum = value.getTotalPrice();
                          return Container(
                            width: width/1.1,
                            height: height/17,
                            decoration: const BoxDecoration(border: Border(
                                top: BorderSide(color:clblack),
                                bottom: BorderSide(color: Colors.black))),
                            child: Padding(
                              padding: const EdgeInsets.only(right:28),
                              child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight. w800,
                                        color: Colors.black),
                                  ),

                                  SizedBox(width: width/7),
                                   Text(

                                      value.getTotalPrice().toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),);
                        }
                      ),
                      SizedBox(height: 11),


                    ],
                  ),
                ),
              ),


            ],
          ),
        ),

      ),
    );
  }
}
