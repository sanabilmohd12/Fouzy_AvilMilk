import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/constants/custom_icons_icons.dart';
import 'package:fouzy/view/printerScreen.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';

class Cart_Screen extends StatelessWidget {
  const Cart_Screen({super.key});

  @override
  Widget build(BuildContext context) {
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
                                            const SizedBox(height: 20),

                                            Text("dateandtime"),

                                            const SizedBox(height: 10),
                                            Text("no.of items "),
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
                                                  callNext(
                                                      context, Printerscreen());
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
      body: SingleChildScrollView(
        child: Container(
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
                                  color: Color(0xffFFF89A),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    items.itemphoto == ""
                                        ? Container(
                                            width: width,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/Sundae (1).png"),
                                              ),
                                            ),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        value.delefromtecart(
                                                            items.cartid,
                                                            context);
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        size: 35,
                                                      )),
                                                )),
                                          )
                                        : Container(
                                            width: width,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    items.itemphoto),
                                              ),
                                            ),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        value.delefromtecart(
                                                            items.cartid,
                                                            context);
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        size: 35,
                                                      )),
                                                )),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                            child: text(
                                                items.itemname,
                                                FontWeight.w800,
                                                cgreen,
                                                items.itemname.length >= 15
                                                    ? 20
                                                    : 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height / 55,
                                    ),
                                    Container(
                                        height: height / 19,
                                        width: width,
                                        color: Color(0xfff9ea1f),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0),
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        bottom: Radius.circular(
                                                            10))),
                                            tileColor: Color(0xfff9ea1f),
                                            leading: IconButton(
                                                onPressed: () {
                                                  value.additems();
                                                },
                                                icon: const Icon(
                                                  CustomIcons.minus_circle,
                                                  color: Colors.red,
                                                )),
                                            title: Center(
                                              child: text(
                                                  value.count.toString(),
                                                  FontWeight.w400,
                                                  cgreen,
                                                  20),
                                            ),
                                            trailing: IconButton(
                                                onPressed: () {
                                                  value.minusitems();
                                                },
                                                icon: Icon(
                                                  CustomIcons.plus_circle,
                                                  color: cgreen,
                                                )),
                                          ),
                                        )

                                        // Row(
                                        //   children: [
                                        //     IconButton(onPressed: (){}, icon: Icon(CustomIcons.minus_circle,color: Colors.red,)),
                                        //     FittedBox(
                                        //         child: text(
                                        //             "000",
                                        //             FontWeight.w400,
                                        //             cgreen,
                                        //             30)),
                                        //     IconButton(onPressed: (){}, icon: Icon(CustomIcons.plus_circle,color: cgreen,))
                                        //   ],
                                        // ),
                                        ),
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
