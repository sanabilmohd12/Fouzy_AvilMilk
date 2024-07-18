import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:screenshot/screenshot.dart';

import '../constants/myimages.dart';

class Printerscreen extends StatelessWidget {
  const Printerscreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 15,),



              Screenshot(
                controller: screenshotController,
                child: Container(
                  color: cWhite,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                        child: Container(
                          // height: height / 15,
                          width: width,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9), color: cgreen),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  "Invoice",
                                  style: TextStyle(
                                      fontSize: 31,
                                      color: Color(0xff343992)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 7),
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/PITONSOFT LOGO.png",
                                  ),
                                  height: 40,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 11),
                      Text(
                        'FOUZY AVIL MILK',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff119246),
                        ),
                      ),
                      Image.asset('assets/fouzylogo.png',scale: 15,),

                      const Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Receipt No:",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Name :",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Abu dhabi | 500 | Apartment Name | 676765",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),),
                            Text(
                              "City",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Country",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 34),
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(fit: FlexFit.tight,
                              flex: 3,
                              child: Column(
                                children: [
                                  Text(
                                    "Items",textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                  ),
                                  Text(
                                    " ",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Courier Charge",textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "(AED)",
                                  // textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ],
                            ),

                            Flexible(fit: FlexFit.tight,
                              flex: 3,
                              child: Text(
                                "Tax \n(AED)",textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                            Flexible(fit: FlexFit.tight,
                              flex: 4,
                              child: Text(
                                "Amount (AED)",textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                          ]),
                      const SizedBox(height: 10),
                      Container(width: width / 1.1, height: 1, color: Colors.black),
                      // Divider(thickness:  1,color: clblack,endIndent: 5,indent: 5,),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: width / 30),
                                const Flexible(fit: FlexFit.tight,
                                  flex: 3,
                                  child: Text(
                                    "#452222",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ),
                                // SizedBox(width: width / 22),
                                const Flexible(fit: FlexFit.tight,
                                  flex: 6,
                                  child: Text(
                                    "150",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ),
                                // SizedBox(width: width / 3.1),
                                const Flexible(fit: FlexFit.tight,
                                  flex: 3,
                                  child: Text(
                                    "0.25",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ),
                                // SizedBox(width: width / 8),
                                const Flexible(
                                  fit: FlexFit.tight,
                                  flex: 4,
                                  child: Text(
                                    "151",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            );
                          },),
                      ),

                      const SizedBox(height:60),
                      Container(
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),

                              SizedBox(width: width/7),
                              const Text(

                                '302',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),),
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
