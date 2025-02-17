import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';
import 'cartScreen.dart';

class Juice_ShakesListScreen extends StatelessWidget {
  const Juice_ShakesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Mainprovider provider = Provider.of<Mainprovider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getavilmilktypes();
    });

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final int index1;
    return Scaffold(
        backgroundColor: cYellow,

        appBar: AppBar(
          title: const Text(
            "FOUZY JUICE & SHAKES",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32),
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
                            return TextField(
                              onChanged: (text){
                                value.juicesearch(text);
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
                Consumer<Mainprovider>(builder: (context, value, child) {
                  return value.getjucieloader
                      ? Center(child: CircularProgressIndicator(
                            color: cgreen,
                          ),
                        )
                      : value.filterjuiceshakesitemslist.length>0?Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 30),
                          child: Consumer<Mainprovider>(
                              builder: (context, value, child) {
                            print("jhgfdszxcvb" +
                                value.filterjuiceshakesitemslist.length.toString());

                            return GridView.builder(
                              itemCount: value.filterjuiceshakesitemslist.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 0.5,
                                      crossAxisCount: 3,
                                      childAspectRatio: 1.3),
                              itemBuilder: (context, index) {
                                var item = value.filterjuiceshakesitemslist[index];
                                return GestureDetector(
                                    onTap: () {
                                      value.AddCartDetails(item.name, item.id,
                                          item.price, item.categoryname, "", context);
                                      value.JUICESsetCheckboxValue(
                                          index, !value.JUICESgetCheckboxValue(index));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      width: width,
                                      // height: height * .12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: cYellow,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // decoration: BoxDecoration(
                                            //     color: Colors.transparent,
                                            //     image: DecorationImage(
                                            //         image: item.avilphoto != ""
                                            //             ? NetworkImage(
                                            //           item.avilphoto,
                                            //         )
                                            //             : AssetImage(""))),

                                            child: Consumer<Mainprovider>(
                                                builder: (context, value, child) {
                                              return Align(
                                                  alignment: Alignment.topRight,
                                                  child: Transform.scale(
                                                    scale: 1.5,
                                                    child: Checkbox(
                                                      shape: CircleBorder(),
                                                      value: value
                                                          .JUICESgetCheckboxValue(index),
                                                      onChanged: (bool? newValue) {
                                                        value.AddCartDetailsJuices(
                                                            item.name,
                                                            item.id,
                                                            item.price,
                                                            item.categoryname,
                                                            context);
                                                        value.JUICESsetCheckboxValue(
                                                            index, newValue ?? false);
                                                      },
                                                      checkColor: Colors.green,
                                                      fillColor:
                                                          WidgetStatePropertyAll(
                                                              Colors.white),
                                                    ),
                                                  ));
                                            }),
                                          ),
                                          FittedBox(
                                              child: text(item.name, FontWeight.w800,
                                                  cgreen, 25)),
                                          FittedBox(
                                              child: text("₹" + item.price,
                                                  FontWeight.w800, cgreen, 25)),
                                          SizedBox(),
                                        ],
                                      ),
                                    ));
                              },
                            );
                          }),
                        ):Center(child: Text("The list is empty"));
                }),
              ],
            ),
          ),
        ));
  }
}
