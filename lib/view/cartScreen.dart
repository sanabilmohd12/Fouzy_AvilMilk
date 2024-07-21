
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/constants/custom_icons_icons.dart';
import 'package:fouzy/view/printerScreen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';

class Cart_Screen extends StatelessWidget {
  const Cart_Screen({super.key});

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
        return value.cartitemslist.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 150),
                child: SizedBox(
                  height: 65,
                  width: width / 1.1,
                  child:
                      Consumer<Mainprovider>(builder: (context, value, child) {
                    return value.loader
                        ? CircularProgressIndicator(
                            color: cgreen,
                          )
                        : FloatingActionButton(
                            onPressed: () {
                              final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
                           value.getordercount();

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Form(key: _formKey,
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

                                            Text(formattedDate,style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),

                                            const SizedBox(height: 10),

                                            TextFormField(
                                              keyboardType: TextInputType.name,
                                              controller: value.namecontroller,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                labelText: 'Name',
                                                isDense: true,
                                                labelStyle: const TextStyle(
                                                  // fontFamily: fontRegular,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter Customer Name';
                                                }
                                                return null;
                                              },
                                              style:
                                                  const TextStyle(color: clblack),
                                            ),
                                            const SizedBox(height: 10),

                                            TextFormField(
                                              keyboardType: TextInputType.number,
                                              controller: value.desknocontroller,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                labelText: 'Desk',
                                                isDense: true,
                                                labelStyle: const TextStyle(
                                                  // fontFamily: fontRegular,

                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  borderSide: const BorderSide(
                                                      color: clblack),
                                                ),
                                              ),

                                              style:
                                                  const TextStyle(color: clblack),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter Desk Number';
                                                }
                                                return null;
                                              },
                                            ),

                                            const SizedBox(height: 10),
                                            Consumer<Mainprovider>(
                                                builder: (context, value,child) {
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 15),
                                                    height: height / 20,
                                                    width: width/2 ,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(width: 2, color: cgreen),
                                                      color: cWhite,
                                                    ),
                                                    child: DropdownButton(
                                                      // Initial Value
                                                      underline:Container(color: Colors.white) ,
                                                      value:value.dropdownval,
                                                      icon: const Icon(Icons.keyboard_arrow_down),
                                                      items:value.odertype.map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(items,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: cBlue)),
                                                        );
                                                      }).toList(),
                                                      onChanged: (String? newVal) {
                                                        value.dropdown(newVal!);
                                                        // value.layerSelection(newVal);
                                                      },
                                                    ),
                                                  );
                                                }
                                            ),

                                            // checkbox
                                          ],
                                        )),
                                        actions: [
                                          //Submit
                                          Consumer<Mainprovider>(builder:
                                              (context, adminProVal, child) {
                                            return InkWell(
                                              onTap: () async {
                                                final FormState? form = _formKey.currentState;
                                                if (form!.validate()) {
                                                  value.ordercount();
                                                  value.getCartItems();
                                                  callNext(
                                                      context, Printerscreen(name: adminProVal.namecontroller.text,deskno: adminProVal.desknocontroller.text,ordertype:adminProVal.dropdownval,datetime: formattedDate,));
                                                }



                                              },
                                              child: Container(
                                                // width: width,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: ShapeDecoration(
                                                  color: cgreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(70),
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
        title: const Text("Items",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
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
      body: Container(
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
                return
                    // value.getcart
                    //   ? Center(
                    //       child: CircularProgressIndicator(
                    //       color: cgreen,
                    //     ))
                    //   :
                    value.cartitemslist.isNotEmpty
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
                              // var itemcountprice= items.itemprice+int.parse(value.count.toString();
                              return Container(
                                // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                                      decoration: items.itemphoto == ""
                                          ? BoxDecoration(
                                              color: Color(0xffFFF89A),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/Sundae (1).png"),
                                              ),
                                            )
                                          : BoxDecoration(
                                              color: Color(0xffFFF89A),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    items.itemphoto),
                                              ),
                                            ),
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
                                                        items.cartid, context);
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 35,
                                                  ),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                                width: width / 6,
                                                height: height / 20,
                                                decoration: ShapeDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Color(0xff0a410b),
                                                    Color(0xff1e7c22),
                                                    Color(0xff0a410b),
                                                  ]),
                                                  shape: RoundedRectangleBorder(
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
                                                  direction: ShimmerDirection.ltr,
                                                  child: Center(
                                                    child: Text(
                                                      items.count == 1
                                                          ? "₹ " +
                                                              items.itemprice
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                items.itemname,
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: height/100,
                                    // ),

                                    SizedBox(
                                      height: height / 26,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                bottom: Radius.circular(30))),
                                        tileColor: Color(0xfff9ea1f),
                                        leading: IconButton(
                                            onPressed: () {
                                              value.countDecrement(index);
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
                                              value.countIncrement(index);
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
                        : Center(child: Text("order something"));
              }),

            ],
          ),
        ),
      ),
    );
  }
}
