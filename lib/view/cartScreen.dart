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
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: SizedBox(
          height: 65,
          width: width / 1.1,
          child: Consumer<Mainprovider>(builder: (context, value, child) {
            return value.loader
                ? CircularProgressIndicator(
              color: cgreen,
            )
                : FloatingActionButton(
              onPressed: () {
                callNext(context, Printerscreen());
              },
              elevation: 0,
              backgroundColor:cgreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              child: text(
                "Save",
                FontWeight.w700,
                cWhite,
                18,
              ),
            );
          }),
        ),
      ),
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
        child: Consumer<Mainprovider>(builder: (context, value, child) {
          return
            // value.getcart
            //   ? Center(
            //       child: CircularProgressIndicator(
            //       color: cgreen,
            //     ))
            //   :
            value.cartitemslist.isNotEmpty?GridView.builder(
              itemCount: value.cartitemslist.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      items.itemphoto==""?
                      Container(
                        width: width,
                        height: 250,

                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage("assets/Sundae (1).png"),
                          ),
                        ),
                        child: Align(alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(onTap: () {
                                value.delefromtecart(items.cartid,context);

                              },
                                  child: Icon(Icons.delete,size: 35,)),
                            )),
                      ): Container(
                        width: width,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(items.itemphoto),
                          ),
                        ),
                        child: Align(alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(onTap: () {
                                value.delefromtecart(items.cartid,context);
                              },
                                  child: Icon(Icons.delete,size: 35,)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: text(
                                  items.itemname, FontWeight.w800, cgreen,  items. itemname.length>=15?20:25),
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
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10))),
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
                                    value.count.toString(), FontWeight.w400, cgreen, 20),
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
            ):Center(child: Text("order something"));
        }),
      ),
    );
  }
}