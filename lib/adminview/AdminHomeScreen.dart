import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import 'AvilMilkListScreen.dart';
import 'addMainCategory.dart';
import 'maincateroylist.dart';

class Admin_Home_Screen extends StatelessWidget {
  const Admin_Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            appbarbkgd,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              back(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: cgreen,
              size: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: text(
            "Admin",
            FontWeight.w700,
            cgreen,
            18,
          ),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return InkWell(onTap: () {
          
                  },
                      child: Button(height*.10,width,cgreen,"Fouzy Special",cWhite,FontWeight.w800, 22));
                }
              ),
              Builder(
                builder: (context) {
                  return InkWell(onTap: () {
                        callNext(context, Main_Category());
                  },
                      child: Button(height*.10,width,cgreen,"Main Category",cWhite,FontWeight.w800, 22));
                }
              ),
              Builder(
                builder: (context) {
                  return InkWell(onTap: () {
                     callNext(context, Avil_Milk_Screen());
                  },
                      child: Button(height*.10,width,cgreen,"Avail  Milks",cWhite,FontWeight.w800, 22));
                }
              ),
              Builder(
                builder: (context) {
                  return InkWell(onTap: () {
          
                  },
                      child: Button(height*.10,width,cgreen,"Ice Creams",cWhite,FontWeight.w800, 22));
                }
              ),
              Builder(
                builder: (context) {
                  return InkWell(onTap: () {
          
                  },
                      child: Button(height*.10,width,cgreen,"Jucies",cWhite,FontWeight.w800, 22));
                }
              ),
            ],
          ),
        ) ,


      ),
    );
  }
}
