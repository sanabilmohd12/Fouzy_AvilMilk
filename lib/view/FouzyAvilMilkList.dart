import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';
import 'cartScreen.dart';

class FouzyAvilMilkListScreen extends StatelessWidget {
  FouzyAvilMilkListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: cYellow,
      appBar: AppBar(
        title: const Text(
          "FOUZY AVILMILK",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bgimg.jpeg'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height/20, left: 30,right: 30),
                child: Container(
                    width: width/1,
                    decoration: BoxDecoration(
                        border: Border.all(color: cYellow, width: 5,),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow:[
                          BoxShadow(
                              offset: Offset(3, 4),
                              blurRadius: 3,
                              spreadRadius: -3,
                              color: cYellow
                          ),
                        ]
                    ),
                    child: Consumer<Mainprovider>(
                        builder: (context, value, child) {
                          print("anas monna"+value.AVILcheckboxStates.toString());
                          return TextField(
                            onChanged: (text){
                              value.filterAvilmilk(text);
                            },
                            cursorColor: clblack,
                            decoration: InputDecoration(
                              fillColor: cWhite,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                              ),
                              prefixIcon: Icon(Icons.search, color: cGrey, size: height/60,),
                              hintText: "Search...",
                              hintStyle: TextStyle(
                                color: cGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: height/70,
                              ),
                            ),
                          );
                        }
                    )
                ),
              ),

              FutureBuilder(
                future: Provider.of<Mainprovider>(context, listen: false).getavilmilktypes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: cgreen,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else {
                    return Consumer<Mainprovider>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
                          child: GridView.builder(
                            itemCount: value.filteravilmilklist.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                                crossAxisCount: 2,
                                childAspectRatio: 1
                            ),
                            itemBuilder: (context, index) {
                              var item = value.filteravilmilklist[index];
                              return GestureDetector(
                                onTap: () {
                                  value.AddCartDetails(
                                      item.name,
                                      item.id,
                                      item.price,
                                      item.maincatrgoryname,
                                      item.avilphoto,
                                      context
                                  );
                                  value.AVILsetCheckboxValue(index, !value.AVILgetCheckboxValue(index));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  width: width,
                                  height: height * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: cYellow,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width,
                                        height: height/5.5,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            image: DecorationImage(
                                                image: item.avilphoto != ""
                                                    ? NetworkImage(item.avilphoto,)
                                                    : AssetImage("assets/Sundae (1).png")
                                            )
                                        ),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Transform.scale(
                                              scale: 1.5,
                                              child:Checkbox(
                                                shape: CircleBorder(),
                                                value: value.AVILgetCheckboxValue(index),  // Remove the || value.isInCart(...) check
                                                onChanged: (bool? newValue) {
                                                  value.AddCartDetailsAvilMilk(
                                                      item.name,
                                                      item.id,
                                                      item.price,
                                                      item.maincatrgoryname,
                                                      item.avilphoto,
                                                      context
                                                  );
                                                  value.AVILsetCheckboxValue(index, newValue ?? false);
                                                  if (newValue == true) {
                                                    value.cartItemsControlls('AVIL_MILK', item.id, item);
                                                  } else {
                                                    value.cartItemsControlls('AVIL_MILK', item.id, item);
                                                  }
                                                },
                                                checkColor: Colors.green,
                                                fillColor: WidgetStatePropertyAll(Colors.white),
                                              )
                                            )
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: width/50, bottom: height/30),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                text(
                                                  item.name,
                                                  FontWeight.w800,
                                                  cgreen,
                                                  width/30,
                                                  maxLines: 1,
                                                  // width: width * 0.3,
                                                ),
                                                text(
                                                  item.describtion,
                                                  FontWeight.w400,
                                                  cgreen,
                                                  width/40,
                                                  maxLines: 1,
                                                  // width: width * 0.3,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: height/20,
                                              width: width/10,
                                              decoration: BoxDecoration(
                                                  color: cgreen,
                                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(12))
                                              ),
                                              child: Shimmer(
                                                gradient: LinearGradient(colors: [
                                                  cWhite,
                                                  cYellow,
                                                  cGrey,
                                                ]),
                                                direction: ShimmerDirection.rtl,
                                                child: Center(
                                                  child: text(
                                                    "₹ ${item.price}",
                                                    FontWeight.w700,
                                                    cWhite,
                                                    20,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}