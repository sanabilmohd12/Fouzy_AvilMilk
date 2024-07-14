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
                      child:  Padding(
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
                                return Flexible(
                                  child:
                                  // value2.filterDeliveryHistoryList.length>0?
                                  ListView(
                                    children: [
                                      ListView.separated(
                                        separatorBuilder: (context, index) {

                                          return SizedBox(height: 16,);
                                        },
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          // var item =value2.filterDeliveryHistoryList[index];
                                          return Container(width: width,decoration:
                                          BoxDecoration(color:cWhite ,
                                              borderRadius: BorderRadius.circular(30),   boxShadow:[
                                                BoxShadow(
                                                    offset: Offset(3, 4),
                                                    blurRadius: 8,
                                                    spreadRadius: -1,
                                                    color: Colors.black12),
                                              ]

                                          ),

                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 22,right: 22,bottom: 22),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Padding(
                                                  //   padding: const EdgeInsets.only(left: 22),
                                                  //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                  //     children: [
                                                  //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //         children: [
                                                  //           Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text("Tracking ID",style: TextStyle(fontFamily:fontRegular ,fontSize:13 ,fontWeight: FontWeight.w400,color: fontgrey2),),
                                                  //               Text(item.trackingid,style: TextStyle(fontFamily:fontMedium ,fontSize:16 ,fontWeight: FontWeight.w500,color: fontblue),),
                                                  //             ],
                                                  //           ),
                                                  //           Container(height:height/13,width:width/13 ,child: Icon(Icons.check_circle_outlined,color: clwhite,size: 20,),
                                                  //             decoration: BoxDecoration(shape: BoxShape.circle,color: fontgreen),)
                                                  //         ],
                                                  //       ),
                                                  //       Text(value2.outputDayNode3.format(item.time),style:
                                                  //       TextStyle(fontFamily:fontRegular ,fontSize:13 ,
                                                  //           fontWeight: FontWeight.w400,
                                                  //           color: fontgrey2),),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  SizedBox(height: 14,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 13
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Column(
                                                              children: <Widget>[
                                                                Container(

                                                                  margin: EdgeInsets.only(top: 5),
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(3.5),
                                                                    child: Container(
                                                                      height: 20,width: 20,
                                                                      decoration: BoxDecoration(shape: BoxShape.circle,  color: cWhite,),

                                                                    ),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      gradient: LinearGradient(colors: [
                                                                        cBlue
                                                                      ])

                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //   height: 65,
                                                                //   child: CustomPaint(
                                                                //     painter: GradientDashPainter(
                                                                //       direction: Axis.vertical,
                                                                //       length: 77,
                                                                //       dashLength: 6,
                                                                //       dashGradient: LinearGradient(
                                                                //         colors: [primarygrad1, primarycgrad2 ], // Gradient colors
                                                                //         begin: Alignment.topCenter,
                                                                //         end: Alignment.bottomCenter,
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // ),


                                                              ],
                                                            ),
                                                            SizedBox(width: 7,),

                                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("item.pickaddress",style: TextStyle(fontWeight:FontWeight.w400 ,fontSize:12 ,),),
                                                                SizedBox(height: height/34,),
                                                                Text("item.deliveraddress",style: TextStyle( fontSize: 12,fontWeight:FontWeight.w400 ),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Align(alignment: Alignment.bottomRight,
                                                        //     child: Text(item.orderStatus=='ASSIGNED'?
                                                        //     'DEPARTED':item.orderStatus=='PICKUP'?
                                                        //     'PICKED UP':
                                                        //     item.orderStatus,
                                                        //       style: TextStyle(
                                                        //           color:
                                                        //           item.orderStatus=='DELIVERED'?
                                                        //           Colors.green:
                                                        //           item.orderStatus=='REQUESTED'?
                                                        //           Colors.red:
                                                        //           item.orderStatus=='ASSIGNED'?
                                                        //           Colors.deepPurpleAccent:
                                                        //           item.orderStatus=='PICKUP'?
                                                        //           Colors.blue:Colors.black
                                                        //       ),))
                                                      ],
                                                    ),
                                                  )

                                                ],
                                              ),
                                            ),
                                          );
                                        },),
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
                                                                 cBlue
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
                                    ],
                                  )
                                    // Center(child: Text("List empty")),
                                );
                              }
                          ),
                          SizedBox(height: 60,),

                        ],),
                      ),
                ),

    );
  }

}
