import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    int selectedContainerIndex=0;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cYellow,
      appBar: AppBar(
        title: const Text("ORDER SUMMERY",
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
      body:
                Container(
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
                      child:  SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: [
                        
                            SizedBox(height: 20,),
                            Container(
                                // width: width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow:[
                                      BoxShadow(
                                          offset: Offset(3, 4),
                                          blurRadius: 8,
                                          spreadRadius: -1,
                                          color: Colors.black12),
                                    ]
                                ),
                                child: Consumer<Mainprovider>(
                                    builder: (context,value,child) {
                                      return TextField(
                                        onChanged: (text){
                                          // value.searchOrdersBoy(text);
                        
                        
                                        },
                                        cursorColor: clblack,
                                        // controller:value.searchBoyHistoryCT,
                                        decoration: InputDecoration(
                                          fillColor:cWhite,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:BorderRadius.circular(30) ,
                                              borderSide: BorderSide.none),
                                          prefixIcon: Icon(Icons.search,color:cGrey,size: 24,),
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                            color:cGrey,
                                            fontWeight: FontWeight.w400,
                                            // fontFamily: fontRegular,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }
                                )
                            ),
                        
                            SizedBox(height: 18,),
                            Consumer<Mainprovider>(
                                builder: (context,value2,child) {
                                  return
                                    // value2.totalRecords>value2.filterDeliveryHistoryList.length?
                                    InkWell( onTap: (){
                                      // value2.newLimit=value2.newLimit+15;
                                      // value2.fetchScannedOrdeHistory(widget.boyID,);
                                      // // value2.fetchTotalRecords(widget.boyID,);
                                      // adminProvider.applyFilter(selectedContainerIndex == null
                                      //     ? 'All' : names[selectedContainerIndex]);
                                    },
                                        child:Center(
                                            child:  Container(
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  gradient:
                                                  LinearGradient(
                                                      colors: [
                                                        cBlue,
                                                        cYellow,
                                                      ]),borderRadius: BorderRadius.circular(16)),
                                              width: width*0.3,
                                              height: 30,
                                              child: Center(child: Text("Load More",
                                                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                                            )
                                        )
                                    );
                                }
                            ),
                        
                            Consumer<Mainprovider>(
                                builder: (context,value2,child) {
                                  print(value2.orderlist.length);
                                  return  ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: value2.orderlist.length,
                                    itemBuilder: (context,index) {
                                      print("sdddddddddddddddd"+ value2.orderlist.length.toString());
                                      var data=value2.orderlist[index];
                                      return Container(
                                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                        width: width,
                                         height: 150,
                                        decoration:
                                      BoxDecoration(
                                          color:cWhite ,
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow:[
                                            BoxShadow(
                                                offset: Offset(3, 4),
                                                blurRadius: 8,
                                                spreadRadius: -1,
                                                color: Colors.black12),
                                          ]
                        
                                      ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),

                                              width: 150,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                image: DecorationImage(
                                                  image: AssetImage("assets/Sundae (1).png"),
                                                ),
                                              ),),
                                            Column(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(data.customername),
                                                Text(data.invoiceno),
                                                Text(data.datetime),
                                                Text(data.totalprice.toString(),

                                                ),
                        
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(data.ordertype),
                                                Container(
                                                 height: 50,
                                                 width:  100,
                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.red),
                                                 child:Center(child: Text("view more")) ,)
                                              ],
                                            ),
                                          ],
                                        ),
                        
                        
                                      );
                                    }
                                  );
                                }
                            ),
                            SizedBox(height: 60,),
                        
                          ],),
                        ),
                      ),
                ),

    );
  }

}
