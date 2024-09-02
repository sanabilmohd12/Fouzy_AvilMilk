import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';

class FouzyMultiple extends StatelessWidget {
  FouzyMultiple({super.key,});

  @override
  Widget build(BuildContext context) {
    Mainprovider provider = Provider.of<Mainprovider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: cYellow,
      appBar: AppBar(
        title: const Text("FOUZY SPECIAL AVILMILK",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
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
                                color: cYellow),
                          ]
                      ),
                      child: Consumer<Mainprovider>(
                          builder: (context, value, child) {
                            return TextField(
                              onChanged: (text){
                                value.filterfsptypes(text);
                              },
                              cursorColor: clblack,
                              decoration: InputDecoration(
                                fillColor: cWhite,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
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

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 30),
                  child: Consumer<Mainprovider>(
                    builder: (context, value, child) {
                      print("dfgkgk"+value.filterfspavilmilklist.length.toString());
                      return GridView.builder(

                        itemCount: value.filterfspavilmilklist.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2,
                            childAspectRatio: 1
                        ),
                        itemBuilder: (context, index) {
                          var item = value.filterfspavilmilklist[index];
                          print("hrewasdcfvgbnm"+value.filterfspavilmilklist.length.toString());
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
                              value.FSPsetCheckboxValue(index, !value.FSPgetCheckboxValue(index));
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
                                                ? NetworkImage(item.avilphoto)
                                                : AssetImage("") as ImageProvider
                                        )
                                    ),
                                    child: Consumer<Mainprovider>(
                                        builder: (context, value, child) {
                                          return Align(
                                              alignment: Alignment.topRight,
                                              child: Transform.scale(
                                                scale: 1.5,
                                                child: Checkbox(
                                                  shape: CircleBorder(),
                                                  value: value.FSPgetCheckboxValue(index) ||
                                                      value.isInCart("AVIL_MILK", item.id),
                                                  onChanged: (bool? newValue) {
                                                    value.AddCartDetails(item.name, item.id, item.price, item.maincatrgoryname, item.avilphoto, context);
                                                    value.FSPsetCheckboxValue(index, newValue ?? false);
                                                    if (newValue == true) {
                                                      value.cartItemsControlls('AVIL_MILK', item.id, item);
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        content: Text("Item added to cart"), duration: Duration(seconds: 2),
                                                      ));
                                                    } else {
                                                      value.cartItemsControlls('AVIL_MILK', item.id, item);
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        content: Text("Item removed from cart"),
                                                        duration: Duration(seconds: 2),
                                                      ));
                                                    }
                                                  },
                                                  checkColor: Colors.green,
                                                  fillColor: MaterialStateProperty.all(Colors.white),
                                                ),
                                              )
                                          );
                                        }
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
                                              width/27,
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}