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
             backgroundColor: Colors.cyan,
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  color: Colors.white,
                  height: height / 2.8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey, borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Tracking ID",
                                  style: TextStyle(
                                      fontSize: 125,
                                      color: Colors.cyan,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "outputDayNode3.format(customerRecentShipmentList.date)",
                                    // style: const TextStyle(
                                    //     fontFamily: fontRegular,
                                    //     fontSize: textSize14,
                                    //     color: fontgrey2,
                                    //     fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        height: 20,
                                        width: 20,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.5),
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration:  BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: cWhite,
                                            ),
                                          ),
                                        ),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(colors: [
                                              clblack
                                            ])),
                                      ),
                                      // SizedBox(
                                      //   height: 65,
                                      //   child: CustomPaint(
                                      //     painter: GradientDashPainter(
                                      //       direction: Axis.vertical,
                                      //       length: 77,
                                      //       dashLength: 6,
                                      //       dashGradient: const LinearGradient(
                                      //         colors: [
                                      //           primarygrad1,
                                      //           primarycgrad2
                                      //         ], // Gradient colors
                                      //         begin: Alignment.topCenter,
                                      //         end: Alignment.bottomCenter,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Colors.white70
                                            ], // Gradient colors
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(bounds);
                                        },
                                        child: const Icon(
                                          Icons.location_on_outlined,
                                          size: 26,
                                          color: Colors
                                              .white, // Set the color to white or any color you prefer
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   "Spark of Modesty",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w400,
                                    //       fontSize: textSize16,
                                    //       fontFamily: fontRegular),
                                    // ),
                                    Text(
                                     " customerRecentShipmentList.pickupaddress",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                    // Text(
                                    //   "Abu dhabi | 500 | Apartment Name | 676765",
                                    //   style: TextStyle(
                                    //       fontFamily: fontRegular,
                                    //       fontSize: 11,
                                    //       fontWeight: FontWeight.w400,
                                    //       color: fontgrey2),
                                    // ),
                                    // Text("(265)523565 , (265)125625",
                                    //     style: TextStyle(
                                    //         fontFamily: fontRegular,
                                    //         fontSize: 11,
                                    //         fontWeight: FontWeight.w400,
                                    //         color: fontgrey2)),
                                    SizedBox(
                                      height: 30,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
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
                      Text("dcdcd",
                        style:  TextStyle(
                            fontWeight: FontWeight.w500,
                            color: cBlue,
                            fontSize: 19),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill to"
                              ,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Muhammed Al Wariz P...",
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

              const Padding(
                padding: EdgeInsets.only(right: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Terms & Conditions",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    Text(
                      "The invoice generated for courier charge only.\nAny Kind of product related Invoice will be different.",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 21),
              Container(
                height: 75,
                width: width / 1.1,
                decoration: BoxDecoration(
                    color: cBlue, borderRadius: BorderRadius.circular(7)),
                child: Column(
                  children: [
                    const SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Powered by",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        SizedBox(width: width / 80),
                        const Image(
                          image: AssetImage(
                              "assets/images/PITONSOFT TEXTGO-23 1 (1).png"),
                          height: 15,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "     The invoice generated for courier charge only.\nAny Kind of product related Invoice will be different.",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
