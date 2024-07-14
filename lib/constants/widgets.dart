import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:provider/provider.dart';

import '../provider/mainprovider.dart';


Widget text(String name, FontWeight weight, Color mycolor, double size) {
  return Text(
    name,
    style: TextStyle(
        fontWeight: weight,
        color: mycolor,
        fontSize: size,
        fontFamily: "poppines"),
  );
}
Widget textfield( TextInputType keyboardtype,
    String validationtext, String labeltxt,TextEditingController controller) {


  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Container(
      height: 120,

      child: TextFormField(

        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),

        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: keyboardtype,
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(vertical: 14),
          helperText: "",
          labelText: labeltxt,
          labelStyle: TextStyle(fontSize: 18),


          hintStyle: TextStyle(color: Colors.grey[400]),
          // prefixIcon:const Icon(Icons.person,color: Colors.green,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide:  BorderSide(
              color: cWhite,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide:  BorderSide(
              color:cWhite,
              width: 1,
            ),
          ),
        ),
        validator: (value) {
          if (value!.trim().isEmpty) {
            return validationtext;
          } else {
            return null;
          }
        },
      ),
    ),
  );
}

Widget Button( double height,double width,Color mycolor,String text,Color textcolr, FontWeight weight, double size){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
    height:height ,
    width: width,
    decoration: BoxDecoration(color: mycolor,borderRadius: BorderRadius.circular(15),boxShadow: [

      BoxShadow(
        color: lightWhite,
        spreadRadius: 3,
        blurStyle: BlurStyle.inner,blurRadius: 5

      )],),
    child:Center(
      child: Text(
        text,style: TextStyle(color: textcolr,fontWeight: weight,fontSize: size,fontFamily: "poppines"),
      ),
    ) ,
  );
}
Widget btn( double height,double width,Color mycolor,String text,Color textcolr, FontWeight weight, double size,IconData? icn){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    height:height ,
    width: width,
    decoration: BoxDecoration(color: mycolor,borderRadius: BorderRadius.circular(15),boxShadow: [

      BoxShadow(
        color: lightWhite,
        spreadRadius: 3,
        blurStyle: BlurStyle.inner,blurRadius: 5

      )],),
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,style: TextStyle(color: textcolr,fontWeight: weight,fontSize: size,fontFamily: "poppines"),
        ),
        Icon(icn,size: 20,)

      ],
    ) ,
  );
}
Widget savebtn( double height,double width,Color mycolor,String text,Color textcolr, FontWeight weight, double size,){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
    height:height ,
    width: width,
    decoration: BoxDecoration(color: mycolor,borderRadius: BorderRadius.circular(25),
     ),
    child:Center(
      child: Text(
        text,style: TextStyle(color: textcolr,fontWeight: weight,fontSize: size,fontFamily: "poppines"),
      ),
    ) ,
  );



}

Widget gridWidget(int itemCount,double width,double height,ImageProvider image,String imagePath,String name,String price,String description){
  return GridView.builder(
    itemCount: itemCount,
    shrinkWrap: true,
    physics: ScrollPhysics(),
    gridDelegate:
    SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        childAspectRatio: 1),
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: 5, vertical: 5),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cYellow,
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: image != ""
                          ? NetworkImage(
                        imagePath,
                      )
                          : AssetImage(""))),
              child: Consumer<Mainprovider>(
                  builder: (context, value, child) {
                    return Align(
                        alignment: Alignment.topRight,
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            shape: CircleBorder(),
                            value:
                            value.getCheckboxValue(
                                index),
                            onChanged:
                                (bool? newValue) {
                              value.setCheckboxValue(
                                  index,
                                  newValue ?? false);
                            },
                            checkColor: Colors.green,
                            fillColor:
                            WidgetStatePropertyAll(
                                Colors.white),
                          ),
                        ));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                      child: text(
                          name,
                          FontWeight.w800,
                          cgreen,
                          25)),
                  FittedBox(
                      child: text(
                          "₹  " + price,
                          FontWeight.w700,
                          cgreen,
                          20)),
                ],
              ),
            ),
            Column(
              children: [
                FittedBox(
                    child: text(
                        description,
                        FontWeight.w400,
                        cgreen,
                        22)),
              ],
            ),
            SizedBox(),
          ],
        ),
      );
    },
  );
}


