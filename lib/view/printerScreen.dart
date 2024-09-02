import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:fouzy/main.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:fouzy/provider/printerProvider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../constants/myimages.dart';
import 'bttmtest.dart';

class Printerscreen extends StatelessWidget {
  String name;
  String deskno;
  String ordertype;
  String datetime;
  List itemslist;
  Printerscreen(
      {super.key,
      required this.name,
      required this.deskno,
      required this.ordertype,
      required this.datetime,
      required this.itemslist});

  @override
  Widget build(BuildContext context) {
    print(deskno +
        "dcvfvfvfv" +
        name +
        "kgfcvbn" +
        ordertype +
        "uytrfcvbnm" +
        datetime);
    ScreenshotController screenshotController = ScreenshotController();

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
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  // height: height / 15,
                  width: width,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9), color: cgreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text(
                          "Invoice",
                          style: TextStyle(fontSize: 31, color: cYellow),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 7),
                        child: Image(
                          image: AssetImage("assets/Sundae (1).png"),
                          height: 40,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Screenshot(
                controller: screenshotController,
                child: Container(
                  color: cWhite,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/ic_launcher.jpg',
                        ),
                      ),
                      Text(
                        'FOUZY AVIL MILK',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff119246),
                        ),
                      ),
                      Text(
                        'ELAYUR,KOOTTAVIL ROAD,PARAMMAL,KAVANUR',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: cBlack,
                        ),
                      ),
                      Text(
                        'ELAYUR',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: cBlack,
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
                      FittedBox(
                          child: Text(
                              "----------------------------------------------------------------------------------------------------------------------------")),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name :" + name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: cBlack,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date :" + datetime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: cBlack,
                                  ),
                                ),
                                Text(
                                  "Table No :" + deskno,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: cBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order Mode : ' + ordertype,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: cBlack,
                                  ),
                                ),
                                Consumer<Mainprovider>(
                                    builder: (context, value, child) {
                                  return Text(
                                    'Inv No: 000' + value.orderCount.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: cBlack,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),

                      FittedBox(
                          child: Text(
                              "----------------------------------------------------------------------------------------------------------------------------")),

                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 25,
                                height: 50,
                                child: Text(
                                  "SI\nNO",
                                  textAlign: TextAlign.center,
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
                                  "Items",
                                  textAlign: TextAlign.center,
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
                                  "Qty",
                                  textAlign: TextAlign.center,
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
                                  "Rate",
                                  textAlign: TextAlign.center,
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
                                  "Item Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),
                            ]),
                      ),

                      const SizedBox(height: 10),
                      Container(
                          width: width / 1.1, height: 1, color: Colors.black),
                      const SizedBox(height: 10),
                      Consumer<Mainprovider>(builder: (context, value, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.cartitemslist.length,
                          itemBuilder: (context, index) {
                            String slno = value.cartitemslist.length.toString();
                            var items = value.cartitemslist[index];
                            print("uytrds" + items.qty);
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              width: width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 25,
                                    child: Text(
                                      "${index + 1}",
                                      textAlign: TextAlign.center,
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
                                      items.itemName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  // SizedBox(width: width / 3.1),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      items.qty.toString(),
                                      textAlign: TextAlign.center,
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
                                      items.itemPrice,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      items.totalPrice.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),

                      const SizedBox(height: 60),
                      Consumer<Mainprovider>(builder: (context, value, child) {
                        // double Sum = value.getTotalPrice();
                        return Container(
                          width: width / 1.1,
                          height: height / 17,
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: clblack),
                                  bottom: BorderSide(color: Colors.black))),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'Order Total',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                ),
                                SizedBox(width: width / 7),
                                Text(
                                  value.getTotalPrice().toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Consumer<Mainprovider>(builder: (context, mainProvider, child) {
                return Consumer<PrinterProvider>(
                    builder: (context, printerProvider, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: height / 5),
                    child: ElevatedButton(

                      onPressed: () async {

                        mainProvider.addOrdersnew(
                          mainProvider.cartitemslist,
                          name,
                          ordertype,
                          deskno,
                          '000' + mainProvider.orderCount.toString(),
                          mainProvider.getTotalPrice().toString(),
                          context,
                        );

                        callNextReplacement(context,  BottomNavBar(),);

                        mainProvider.deleteAllFromCart( context);
                        mainProvider.ClearAllCheckBoxes(context);

                        try {
                          bool isConnected =
                              await printerProvider.testPrinterConnection(
                                  printerProvider.Ip,
                                  int.parse(printerProvider.boxInPort));

                          if (isConnected) {
                            mainProvider.addOrdersnew(
                              mainProvider.cartitemslist,
                              name,
                              ordertype,
                              deskno,
                              '000' + mainProvider.orderCount.toString(),
                              mainProvider.getTotalPrice().toString(),
                              context,
                            );



                            // Get the total price
                            double totalPrice = mainProvider.getTotalPrice();
                            await printerProvider.printInvoice(
                              context,
                              name: name,
                              deskno: deskno,
                              ordertype: ordertype,
                              datetime: datetime,
                              itemslist: mainProvider.cartitemslist,
                              invoiceNumber: '000${mainProvider.orderCount}',
                              totalPrice: totalPrice,
                            );
                            mainProvider.deleteAllFromCart( context);
                            mainProvider.ClearAllCheckBoxes(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Printing completed successfully.')),
                            );
                            callNextReplacement(context,  BottomNavBar(),);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Printer is not connected. Please check the printer and try again.')),
                            );
                          }
                        } catch (e) {
                          print('Error during printing process: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'An error occurred while trying to print. Please try again.')),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.print,),
                          SizedBox(
                            width:10,
                          ),
                          Text('Print',style: TextStyle(fontSize: 18,),)
                        ],
                      ),
                    ),
                  );
                });
              })
              // Consumer<Mainprovider>(
              //     builder: (context,value,child) {
              //       return GestureDetector(onTap: () async {
              //         double totalPrice = Provider.of<Mainprovider>(context, listen: false).getTotalPrice();
              //         print("Total Price: $totalPrice");
              //         print(name+"heloooooooi"+datetime+"hgvbnm,"+ordertype+"fdcvbnm"+value.orderCount.toString()+"hgvbnm"+value.slno);
              //         value.AddOrder(name, datetime, ordertype, itemslist, deskno
              //             ,'000'+value.orderCount.toString(), totalPrice, value.slno, context);
              //         value.cartitemslist.clear();
              //             value.getMainCategoy();
              //         callNext(context,  BottomNavBarV2());
              //
              //       },
              //         child: Consumer<PrinterProvider>(
              //             builder: (context, printer, child) {
              //               return GestureDetector(
              //                 onTap: () async {
              //                   double totalprice = Provider.of<Mainprovider>(context, listen: false).getTotalPrice();
              //
              //                   // Check printer connection before printing
              //                   bool isConnected = await printer.isPrinterConnected(printer.Ip, int.parse(printer.boxInPort));
              //
              //                   // if (isConnected) {
              //                   //   // If connected, proceed with printing
              //                   //   printer.PrintOrderInvoiceBoxIn(context, printer.Ip);
              //                   //
              //                   //   // Add order to database and navigate
              //                   //   Provider.of<Mainprovider>(context, listen: false).AddOrder(
              //                   //       name,
              //                   //       datetime,
              //                   //       ordertype,
              //                   //       itemslist,
              //                   //       deskno,
              //                   //       '000${Provider.of<Mainprovider>(context, listen: false).orderCount}',
              //                   //       "",
              //                   //       Provider.of<Mainprovider>(context, listen: false).slno,
              //                   //       context
              //                   //   );
              //                   //   Provider.of<Mainprovider>(context, listen: false).cartitemslist.clear();
              //                   //   Provider.of<Mainprovider>(context, listen: false).getMainCategoy();
              //                   //   callNext(context, BottomNavBarV2());
              //                   // } else {
              //                   //   // If not connected, show an error message
              //                   //   ScaffoldMessenger.of(context).showSnackBar(
              //                   //     SnackBar(
              //                   //       content: Text('Printer is not connected. Please check your network connection.'),
              //                   //       backgroundColor: Colors.red,
              //                   //     ),
              //                   //   );
              //                   // }
              //                   Provider.of<Mainprovider>(context, listen: false).AddOrder(
              //                       name,
              //                       datetime,
              //                       ordertype,
              //                       itemslist,
              //                       deskno,
              //
              //                       '000${Provider.of<Mainprovider>(context, listen: false).orderCount}',
              //                     totalprice,
              //                       Provider.of<Mainprovider>(context, listen: false).slno,
              //
              //
              //                     context,
              //                   );
              //
              //                   value.addOrdersnew(
              //                     name,
              //                     datetime,
              //                     ordertype,
              //                     deskno,
              //                   );
              //
              //
              //                   Provider.of<Mainprovider>(context, listen: false).cartitemslist.clear();
              //                   Provider.of<Mainprovider>(context, listen: false).getMainCategoy();
              //                   callNext(context, BottomNavBarV2());
              //                 },
              //                 child: Container(
              //                   height: 50,
              //                   alignment: Alignment.center,
              //                   decoration: ShapeDecoration(
              //                     color: cgreen,
              //                     shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(70),
              //                     ),
              //                   ),
              //                   child: const Text(
              //                     'Submit',
              //                     style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 14,
              //                       fontFamily: 'Poppins',
              //                       fontWeight: FontWeight.w500,
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             }
              //         ),
              //       );
              //     }
              // ),

              // SwipeableButtonView(
              //   buttonText: 'SAVE',
              //   buttonWidget: const Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     color: Colors.white,
              //   ),
              //   activeColor: cgreen,
              //   isFinished: false,
              //   onWaitingProcess: () {
              //     Consumer<Mainprovider>(
              //       builder: (context,value,child) {
              //         return InkWell(onTap: () {
              //
              //
              //         },
              //           child: Container(
              //             height: 50,
              //             alignment: Alignment.center,
              //             decoration: ShapeDecoration(
              //               color: cgreen,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(70),
              //               ),
              //             ),
              //             child: const Text(
              //               'Submit',
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 14,
              //                 fontFamily: 'Poppins',
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //         );
              //       }
              //     );
              //
              //
              //
              //   },
              //   onFinish: () {
              //     Mainprovider provider=Provider.of(context,listen: false);
              //     provider.AddOrder(name, datetime, ordertype, itemslist, deskno
              //         ,'000'+provider.orderCount.toString(), "", provider.slno, context);
              //     // This won't be called due to isFinished: false
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
