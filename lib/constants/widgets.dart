import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/colors.dart';

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
    String validationtext, String labeltxt) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      textAlign: TextAlign.center,
      // controller: controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
        helperText: "",
        labelText: labeltxt,
        labelStyle: TextStyle(fontSize: 12),

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