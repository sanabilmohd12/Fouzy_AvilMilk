


// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fouzy/view/printerScreen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/callFunctions.dart';
import '../constants/colors.dart';
import '../constants/custom_icons_icons.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';

class Cart_Screen extends StatelessWidget {
  const Cart_Screen({super.key});
  //
  // Future<void> fetchData(BuildContext context) async {
  //   final provider = Provider.of<Mainprovider>(context, listen: false);
  //   await provider.getCartItems();
  // }

  @override
  Widget build(BuildContext context) {
    DateTime nows = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(nows);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Consumer<Mainprovider>(builder: (context, value, child) {
        print("abcd" + value.cartitemidlist.toString());

        return value.cartitemslist.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: SizedBox(
                  height: 45,
                  width: width / 3.1,
                  child:
                      Consumer<Mainprovider>(builder: (context, value, child) {
                    return value.loader
                        ? CircularProgressIndicator(
                            color: cgreen,
                          )
                        : FloatingActionButton(
                            onPressed: () {
                              final GlobalKey<FormState> _formKey =
                                  GlobalKey<FormState>();
                              value.getordercount();
                              value.ordercount();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Form(
                                      key: _formKey,
                                      child: AlertDialog(
                                        surfaceTintColor: cYellow,
                                        title: const Center(
                                          child: Text(
                                            "Add details",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                            child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 20),
                                            Text(
                                              formattedDate,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              keyboardType: TextInputType.name,
                                              controller: value.namecontroller,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                labelText: 'Name',
                                                isDense: true,
                                                labelStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Customer Name';
                                                }
                                                return null;
                                              },
                                              style: const TextStyle(
                                                  color: clblack),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  value.desknocontroller,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                labelText: 'Desk',
                                                isDense: true,
                                                labelStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                  color: clblack),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Desk Number';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            Consumer<Mainprovider>(builder:
                                                (context, value, child) {
                                              return Container(
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                height: height / 20,
                                                width: width / 2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 2, color: cgreen),
                                                  color: cWhite,
                                                ),
                                                child: DropdownButton(
                                                  underline: Container(
                                                      color: Colors.white),
                                                  value: value.dropdownval,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  items: value.odertype
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: cBlue)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newVal) {
                                                    value.dropdown(newVal!);
                                                  },
                                                ),
                                              );
                                            }),
                                          ],
                                         )
                                        ),
                                         actions: [
                                           Consumer<Mainprovider>(builder:
                                              (context, adminProVal, child) {
                                            return InkWell(
                                              onTap: () async {
                                                final FormState? form =
                                                    _formKey.currentState;
                                                if (form!.validate()) {
                                                  value.getCartItems();
                                                  value.getitemsid();
                                                  callNext(
                                                      context,
                                                      Printerscreen(
                                                        name: adminProVal
                                                            .namecontroller
                                                            .text,
                                                        deskno: adminProVal
                                                            .desknocontroller
                                                            .text,
                                                        ordertype: adminProVal
                                                            .dropdownval,
                                                        datetime: formattedDate,
                                                        itemslist: value
                                                            .cartitemidlist,
                                                      ));
                                                }
                                              },
                                              child: Container(
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: ShapeDecoration(
                                                  color: cgreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    );
                                  });
                            },
                            elevation: 0,
                            backgroundColor: cWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(42),
                            ),
                            child: text(
                              "Save",
                              FontWeight.w700,
                              cgreen,
                              18,
                            ),
                          );
                  }),
                ),
              )
            : SizedBox();
      }),
      backgroundColor: cYellow,
      appBar: AppBar(
        title: const Text(
            "Orders",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appbar bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body:  Container(
              height: height,
              width: width,
             decoration: ShapeDecoration(
                color: cgreen,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<Mainprovider>(builder: (context, value, child) {
                      return value.cartitemslist.isNotEmpty
                          ? GridView.builder(
                              itemCount: value.cartitemslist.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15,
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0),
                              itemBuilder: (context, index) {
                                var items = value.cartitemslist[index];
                                return Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0xfff9ea1f),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: width,
                                        height: 250,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      value.delefromtecart(
                                                          items.id,
                                                          context);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 35,
                                                    ),
                                                  ),
                                                )
                                            ),
                                            items.itemsphoto!=""?
                                            Image.network(items.itemsphoto):Image.asset("assets/Sundae (1).png"),

                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                  width: width / 6,
                                                  height: height / 20,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Color(0xff0a410b),
                                                      Color(0xff1e7c22),
                                                      Color(0xff0a410b),
                                                    ]),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .horizontal(
                                                        start:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Shimmer(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      cWhite,
                                                      cYellow,
                                                      cgreen,
                                                    ]),
                                                    direction:
                                                        ShimmerDirection.ltr,
                                                    child: Center(
                                                      child: Text(
                                                        items.count == 1
                                                            ? "₹ " +
                                                                items.itemsprice
                                                                    .toString()
                                                            : "₹ " +
                                                                items.totalprice
                                                                    .toString(),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xfffff1e2)),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  items.itemsname,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 26,
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(30))),
                                          tileColor: Color(0xfff9ea1f),
                                          leading: IconButton(
                                              onPressed: () {
                                                value.countDecrement(
                                                    index, items.id);
                                              },
                                              icon: const Icon(
                                                CustomIcons.minus_circle,
                                                color: Colors.red,
                                              )),
                                          title: Center(
                                            child: text(items.count.toString(),
                                                FontWeight.w400, cgreen, 20),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                value.countIncrement(
                                                    index, items.id);
                                              },
                                              icon: Icon(
                                                CustomIcons.plus_circle,
                                                color: cgreen,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Lottie.asset(
                                "assets/bananalottie.json",
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            );
                    }),
                    SizedBox(
                      height: height / 5,
                    )
                  ],
                ),
              ),
            )


    );
  }
}

//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fouzy/view/printerScreen.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../constants/callFunctions.dart';
// import '../constants/colors.dart';
// import '../constants/custom_icons_icons.dart';
// import '../constants/widgets.dart';
// import '../provider/mainprovider.dart';
//
// class Cart_Screen extends StatelessWidget {
//   const Cart_Screen({super.key});
//
//   Future<void> fetchData(BuildContext context) async {
//     final provider = Provider.of<Mainprovider>(context, listen: false);
//     await provider.getCartItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime nows = DateTime.now();
//     String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(nows);
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Consumer<Mainprovider>(
//         builder: (context, value, child) {
//           return value.cartitemslist.isNotEmpty
//               ? Padding(
//             padding: const EdgeInsets.only(bottom: 100),
//             child: SizedBox(
//               height: 45,
//               width: width / 3.1,
//               child: value.loader
//                   ? CircularProgressIndicator(color: Colors.green)
//                   : FloatingActionButton(
//                 onPressed: () {
//                   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//                   value.getordercount();
//                   value.ordercount();
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Form(
//                         key: _formKey,
//                         child: AlertDialog(
//                           surfaceTintColor: Colors.yellow,
//                           title: const Center(
//                             child: Text(
//                               "Add details",
//                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           content: SingleChildScrollView(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 SizedBox(height: 20),
//                                 Text(
//                                   formattedDate,
//                                   style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 TextFormField(
//                                   keyboardType: TextInputType.name,
//                                   controller: value.namecontroller,
//                                   decoration: InputDecoration(
//                                     fillColor: Colors.transparent,
//                                     labelText: 'Name',
//                                     isDense: true,
//                                     labelStyle: const TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(22),
//                                       borderSide: const BorderSide(color: Colors.black),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(22),
//                                       borderSide: const BorderSide(color: Colors.black),
//                                     ),
//                                   ),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter Customer Name';
//                                     }
//                                     return null;
//                                   },
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 TextFormField(
//                                   keyboardType: TextInputType.number,
//                                   controller: value.desknocontroller,
//                                   decoration: InputDecoration(
//                                     fillColor: Colors.transparent,
//                                     labelText: 'Desk',
//                                     isDense: true,
//                                     labelStyle: const TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(22),
//                                       borderSide: const BorderSide(color: Colors.black),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(22),
//                                       borderSide: const BorderSide(color: Colors.black),
//                                     ),
//                                   ),
//                                   style: const TextStyle(color: Colors.black),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter Desk Number';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Consumer<Mainprovider>(
//                                   builder: (context, value, child) {
//                                     return Container(
//                                       margin: EdgeInsets.symmetric(horizontal: 15),
//                                       height: height / 20,
//                                       width: width / 2,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(width: 2, color: Colors.green),
//                                         color: Colors.white,
//                                       ),
//                                       child: DropdownButton(
//                                         underline: Container(color: Colors.white),
//                                         value: value.dropdownval,
//                                         icon: const Icon(Icons.keyboard_arrow_down),
//                                         items: value.odertype.map((String items) {
//                                           return DropdownMenuItem(
//                                             value: items,
//                                             child: Text(
//                                               items,
//                                               style: TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.blue,
//                                               ),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newVal) {
//                                           value.dropdown(newVal!);
//                                         },
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           actions: [
//                             Consumer<Mainprovider>(
//                               builder: (context, adminProVal, child) {
//                                 return InkWell(
//                                   onTap: () async {
//                                     final FormState? form = _formKey.currentState;
//                                     if (form!.validate()) {
//                                       await value.getCartItems();
//                                       value.getitemsid();
//                                       // Navigate to next screen
//                                     }
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     alignment: Alignment.center,
//                                     decoration: ShapeDecoration(
//                                       color: Colors.green,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(70),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Submit',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 elevation: 0,
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Text(
//                   "Proceed",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//           )
//               : Container();
//         },
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.green.shade800,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         toolbarHeight: 100,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/appbar bg1.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         height: height,
//         width: width,
//         decoration: ShapeDecoration(
//           color: Colors.green,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//           ),
//         ),
//         child: FutureBuilder<void>(
//           future: fetchData(context),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator(color: Colors.green));
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Consumer<Mainprovider>(
//                       builder: (context, value, child) {
//                         return value.cartitemslist.isNotEmpty
//                             ? GridView.builder(
//                           itemCount: value.cartitemslist.length,
//                           shrinkWrap: true,
//                           physics: ScrollPhysics(),
//                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 15,
//                             crossAxisCount: 2,
//                             childAspectRatio: 1.0,
//                           ),
//                           itemBuilder: (context, index) {
//                             var items = value.cartitemslist[index];
//                             print("csdchchdcv"+items.itemPhoto.toString());
//                             return Container(
//                               width: width,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Color(0xfff9ea1f),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     width: width,
//                                     height: 250,
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 value.delefromtecart(items.cartId, context);
//                                               },
//                                               child: Icon(
//                                                 Icons.delete,
//                                                 size: 35,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         items.imageFile != null
//                                             ? Image.file(
//                                           items.imageFile!,
//                                           fit: BoxFit.cover,
//                                           width: 100,
//                                           height: 100,
//                                         )
//                                             :Image.asset("assets/Sundae (1).png"),
//                                         Align(
//                                           alignment: Alignment.topRight,
//                                           child: Container(
//                                             width: width / 6,
//                                             height: height / 20,
//                                             decoration: const ShapeDecoration(
//                                               gradient: LinearGradient(
//                                                 colors: [
//                                                   Color(0xff0a410b),
//                                                   Color(0xff1e7c22),
//                                                   Color(0xff0a410b),
//                                                 ],
//                                               ),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadiusDirectional.horizontal(
//                                                   start: Radius.circular(15),
//                                                 ),
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 items.count == 1
//                                                     ? "₹ " + items.itemPrice.toString()
//                                                     : "₹ " + items.totalPrice.toString(),
//                                                 style: TextStyle(fontSize: 20, color: Color(0xfffff1e2)),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         Align(
//                                           alignment: Alignment.bottomCenter,
//                                           child: Text(
//                                             items.itemName,
//                                             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: height / 26,
//                                     child: ListTile(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
//                                       ),
//                                       tileColor: Color(0xfff9ea1f),
//                                       leading: IconButton(
//                                         onPressed: () {
//                                           value.countDecrement(index, items.cartId);
//                                         },
//                                         icon: const Icon(
//                                           Icons.remove_circle,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                       title: Center(
//                                         child: Text(
//                                           items.count.toString(),
//                                           style: TextStyle(fontWeight: FontWeight.w400, color: Colors.green, fontSize: 20),
//                                         ),
//                                       ),
//                                       trailing: IconButton(
//                                         onPressed: () {
//                                           value.countIncrement(index, items.cartId);
//                                         },
//                                         icon: Icon(
//                                           Icons.add_circle,
//                                           color: Colors.green,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                             : Center(
//                           child: Lottie.asset(
//                             "assets/bananalottie.json",
//                             width: 200,
//                             height: 200,
//                             fit: BoxFit.fill,
//                           ),
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: height / 5,
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
//


