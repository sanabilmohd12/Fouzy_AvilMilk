import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/main.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';

import 'addIcreamTypesScreen.dart';


class IceCreamTypesListScreen extends StatelessWidget {
  String icecategory;
  String icecategoryid;
  String maincategoryid;
   IceCreamTypesListScreen({super.key,required this.icecategory,required this.icecategoryid,required this.maincategoryid});

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
        floatingActionButton:
        Consumer<Mainprovider>(
          builder: (context,value,child) {
            return FloatingActionButton(
              backgroundColor: cgreen,
              child: Icon(Icons.add, color: cWhite, size: 38),
              onPressed: () {
                value.icelistclear();
                callNext(context, AddIceCreamTypesScreen(iceitemfrom: "NEW",iceitemoldid: '',icecategory: icecategory,icecategoryid: icecategoryid,
                maincategoryid: maincategoryid));
              },
            );
          }
        ),

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
          centerTitle: true,

          title: text(
            " Fouzy IceCreams Item",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Consumer<Mainprovider>(
                builder: (context,value,child) {
                  return GridView.builder(
                    itemCount: value.icecreamlist.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 0.5,
                        crossAxisCount: 2,
                        childAspectRatio: 1.3),
                    itemBuilder: (context, index1) {
                      var items = value.icecreamlist[index1];
                      return Container(

                          margin: EdgeInsets.symmetric(
                              horizontal: width / 90,vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.amberAccent,
                          ),
                          child: Column(children: [
                            FittedBox(
                                child: text(items.flavourName, FontWeight.w800,
                                    cgreen, 25)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 48.0,
                                  vertical: height / 65),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) {

                                  return
                                    Column(
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(value.icecreamlist[index1].scoops[index].name ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
                                             SizedBox(width: 10),
                                            Text(value.icecreamlist[index1].scoops[index].price.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),)

                                          ],
                                        ),
                                      ],
                                    );

                                },
                              ),
                            ),
                          ]));
                    },
                  );
                }
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
