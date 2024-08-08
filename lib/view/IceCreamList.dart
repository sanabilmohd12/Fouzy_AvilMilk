import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../provider/mainprovider.dart';

class IceCreamListScreen extends StatelessWidget {
  const IceCreamListScreen({super.key});

  Future<void> _initializeData(BuildContext context) async {
    final provider = Provider.of<Mainprovider>(context, listen: false);
    await provider.getavilmilktypes();
    provider.initializeIceCreamSelections();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: cYellow,
      appBar: AppBar(
        title: const Text(
          "FOUZY ICE CREAMS",
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
      body: FutureBuilder(
        future: _initializeData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Container(
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Text(
                        "ICE CREAMS",
                        style: TextStyle(
                          color: cWhite,
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Consumer<Mainprovider>(
                      builder: (context, value, child) {
                        return GridView.builder(
                          itemCount: value.icecreamlist.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 0.4,
                            childAspectRatio: height / 800,
                          ),
                          itemBuilder: (context, index1) {
                            var items = value.icecreamlist[index1];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: width / 90,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: cYellow,
                              ),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: text(
                                      items.flavourName,
                                      FontWeight.w800,
                                      cgreen,
                                      25,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width / 48.0,
                                      vertical: height / 65,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return CheckboxListTile(
                                          title: Text(items.scoops[index].name,style: TextStyle(fontSize: 18,),),
                                          subtitle: Text(items.scoops[index].price.toString()),
                                          tileColor: cgreen,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          value: items.scoops[index].isClicked,
                                          onChanged: (val) {
                                            value.toggleIceCreamSelection(context, index1, index);
                                            value.icecreamlist[index1].scoops[index].isClicked = val!;
                                            value.notifyListeners();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "DESSERTS",
                      style: TextStyle(
                        color: cWhite,
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                    Consumer<Mainprovider>(
                      builder: (context, value, child) {
                        return GridView.builder(
                          itemCount: value.dessertslist.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 0.4,
                              childAspectRatio: 0.90),
                          itemBuilder: (context, index) {
                            var items = value.dessertslist[index];
                            return GestureDetector(
                              onTap: () {
                                value.setDessertCheckboxValue(
                                    index, !value.getDessertCheckboxValue(index));
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: cYellow,
                                  ),
                                  child: Column(children: [
                                    Container(
                                      width: width,


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
                                                        .getDessertCheckboxValue(index),
                                                    onChanged: (bool? newValue) {
                                                      value.setDessertCheckboxValue(
                                                          index, newValue ?? false);
                                                    },
                                                    checkColor: Colors.green,
                                                    fillColor: WidgetStatePropertyAll(
                                                        Colors.white),
                                                  ),
                                                ));
                                          }),
                                    ),
                                    FittedBox(
                                        child: text(
                                            items.name, FontWeight.w800, cgreen, 25)),
                                    FittedBox(
                                        child: text("₹  " + items.price,
                                            FontWeight.w700, cgreen, 20)),
                                  ])),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}