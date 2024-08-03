// // import 'package:flutter/material.dart';
// // import 'package:fouzy/provider/mainprovider.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../constants/ScrollableWidget.dart';
// // import '../constants/colors.dart';
// //
// // class SalesScreen extends StatelessWidget {
// //   const SalesScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var height = MediaQuery.of(context).size.height;
// //     var width = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //       backgroundColor: cYellow,
// //       appBar: AppBar(
// //         title: const Text("MONTHLY SALES REPORT",
// //             style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
// //         centerTitle: true,
// //         automaticallyImplyLeading: false,
// //         toolbarHeight: 100,
// //         flexibleSpace: Container(
// //           decoration: const BoxDecoration(
// //             image: DecorationImage(
// //               image: AssetImage('assets/appbar bg1.jpg'),
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //         ),
// //         actions: [
// //           Consumer<Mainprovider>(
// //             builder: (context,value,child) {
// //               return InkWell(onTap: () {
// //                 value.salesReport(context);
// //                       },
// //                 child: Icon(Icons.calendar_month_outlined,size: 35,));
// //             }
// //           ),SizedBox(width: 10,)],
// //
// //       ),
// //       body:
// //                 Container(
// //                   height: height,
// //                   width: width,
// //                   decoration: ShapeDecoration(
// //                     color: cgreen,
// //                     shape: const RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(30),
// //                         topRight: Radius.circular(30),
// //                       ),
// //                     ),
// //                   ),
// //                           child:  Flexible(
// //                             fit: FlexFit.tight,
// //                             child: ScrollableWidget(
// //                               child: Container(
// //                                 margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
// //                                 width: width,
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(20), // Add border radius
// //                                   border: Border.all(color: cWhite, width: .8),
// //                                 ),
// //                                 child: Consumer<Mainprovider>(
// //                                     builder: (context,value,child) {
// //                                       return Padding(
// //                                         padding: const EdgeInsets.all(15),
// //                                         child: DataTable(
// //                                             headingRowColor: MaterialStatePropertyAll(Colors.white),
// //                                             columnSpacing: 30,
// //                                             dataRowHeight: 90,
// //                                             border: TableBorder.all(
// //                                               color: Colors.yellow,
// //                                               width: 3,
// //                                             ),
// //                                             columns: const <DataColumn>[
// //                                               DataColumn(
// //                                                 label: Text(
// //                                                   'Date & Time',
// //                                                   textAlign: TextAlign.start,
// //                                                   style: TextStyle(
// //                                                     fontSize: 16,
// //                                                     fontFamily: 'Poppins',
// //                                                     color: Colors.black,
// //                                                     fontWeight: FontWeight.w500,
// //                                                   ),
// //                                                 ),
// //                                               ),
// //                                               DataColumn(
// //                                                 label: Text(
// //                                                   'Items Name',
// //                                                   textAlign: TextAlign.start,
// //                                                   style: TextStyle(
// //                                                     fontSize: 16,
// //                                                     fontFamily: 'Poppins',
// //                                                     color: Colors.black,
// //                                                     fontWeight: FontWeight.w500,
// //                                                   ),
// //                                                 ),
// //                                               ),
// //                                               DataColumn(
// //                                                 label: Text(
// //                                                   'Qty',
// //                                                   textAlign: TextAlign.start,
// //                                                   style: TextStyle(
// //                                                     fontSize: 16,
// //                                                     fontFamily: 'Poppins',
// //                                                     color: Colors.black,
// //                                                     fontWeight: FontWeight.w500,
// //                                                   ),
// //                                                 ),
// //                                               ),
// //                                               DataColumn(
// //                                                 label: Text(
// //                                                   "Price",
// //                                                   textAlign: TextAlign.start,
// //                                                   style: TextStyle(
// //                                                     fontSize: 16,
// //                                                     fontFamily: 'Poppins',
// //                                                     color: Colors.black,
// //                                                     fontWeight: FontWeight.w500,
// //                                                   ),
// //                                                 ),
// //                                               ),   DataColumn(
// //                                                 label: Text(
// //                                                   "Printed",
// //                                                   textAlign: TextAlign.start,
// //                                                   style: TextStyle(
// //                                                     fontSize: 16,
// //                                                     fontFamily: 'Poppins',
// //                                                     color: Colors.black,
// //                                                     fontWeight: FontWeight.w500,
// //                                                   ),
// //                                                 ),
// //                                               ),
// //
// //                                             ],
// //                                             rows: value.orderlist.map((data) {
// //                                               return
// //
// //                                                 DataRow(
// //                                                   cells: <DataCell>[
// //                                                     DataCell(
// //                                                       Text(data.datetime,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),
// //
// //                                                     ),
// //                                                     DataCell(
// //                                                       Text(data.itemname,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),
// //                                                     ),
// //                                                     DataCell(
// //
// //                                                       Text(data.itemqty,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),
// //                                                     ),
// //                                                     DataCell(
// //                                                       Text(data.totalprice.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),
// //
// //                                                     ), DataCell(
// //                                                       Text(data.printed,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),
// //
// //                                                     ),
// //
// //                                                   ],
// //
// //                                                 );
// //                                             }).toList()),
// //                                       );
// //
// //                                     }
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                 ),
// //
// //     );
// //   }
// //
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/ScrollableWidget.dart';
// import '../constants/colors.dart';
// import '../modelClass/oderModel.dart';
// import '../provider/mainprovider.dart';
//
// class SalesScreen extends StatelessWidget {
//   const SalesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: cYellow,
//       appBar: AppBar(
//         title: const Text("MONTHLY SALES REPORT",
//             style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         toolbarHeight: 100,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/appbar bg1.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         actions: [
//           Consumer<Mainprovider>(
//               builder: (context, value, child) {
//                 return GestureDetector(
//                   onTap: () {
//                     value.salesReport(context);
//                   },
//                   child: SizedBox(
//                     height: 40,
//                       width: 40,
//                       child: Icon(Icons.calendar_month_outlined, size: 35)),
//                 );
//               }
//           ),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: Container(
//         height: height,
//         width: width,
//         decoration: ShapeDecoration(
//           color: cgreen,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//           ),
//         ),
//         child: StreamBuilder<List<OrderModel>>(
//           stream: Provider.of<Mainprovider>(context, listen: false).fetchOrderList(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('No orders found'));
//             } else {
//               return ScrollableWidget(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                   width: width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: cWhite, width: .8),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: DataTable(
//                       headingRowColor: MaterialStateProperty.all(Colors.white),
//                       columnSpacing: 30,
//                       dataRowHeight: 90,
//                       border: TableBorder.all(
//                         color: Colors.yellow,
//                         width: 3,
//                       ),
//                       columns: const <DataColumn>[
//                         DataColumn(label: Text('Date & Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
//                         DataColumn(label: Text('Items Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
//                         DataColumn(label: Text('Qty', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
//                         DataColumn(label: Text('Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
//                         DataColumn(label: Text('Printed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
//                       ],
//                       rows: snapshot.data!.expand((order) {
//                         return order.products.entries.map((product) {
//                           return DataRow(
//                             cells: <DataCell>[
//                               DataCell(Text(order.orderDate, style: TextStyle(color: cWhite))),
//                               DataCell(Text(product.key, style: TextStyle(color: cWhite))),
//                               DataCell(Text(product.value.qty, style: TextStyle(color: cWhite))),
//                               DataCell(Text(product.value.price, style: TextStyle(color: cWhite))),
//                               DataCell(Text('N/A', style: TextStyle(color: cWhite))), // Add a 'printed' field to your OrderModel if needed
//                             ],
//                           );
//                         }).toList();
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/ScrollableWidget.dart';
import '../constants/colors.dart';
import '../modelClass/oderModel.dart';
import '../provider/mainprovider.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime day = DateTime.now();
    DateTime onlyDate = DateTime(day.year, day.month, day.day);
    DateTime endDate2 = onlyDate.add(const Duration(hours: 23, seconds: 59, minutes: 59));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: cYellow,
      appBar: AppBar(
        title: const Text("MONTHLY SALES REPORT",
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
        actions: [
          Consumer<Mainprovider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    value.dateWiseorderReport(context);
                  },
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.calendar_month_outlined, size: 35),
                  ),
                );
              }
          ),
          SizedBox(width: 10),
        ],
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
        child: Consumer<Mainprovider>(
          builder: (context, provider, child) {
            if (provider.orderList.isEmpty) {
              return Center(child: Text('No orders found'));
            }
            return ScrollableWidget(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cWhite, width: .8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.white),
                    columnSpacing: 30,
                    dataRowHeight: 90,
                    border: TableBorder.all(
                      color: Colors.yellow,
                      width: 3,
                    ),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Date & Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      DataColumn(label: Text('Items Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      DataColumn(label: Text('Qty', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      DataColumn(label: Text('Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      DataColumn(label: Text('Printed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                    ],
                    rows: provider.orderList.expand((order) {
                      return order.products.entries.map((product) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(order.orderDate, style: TextStyle(color: cWhite))),
                            DataCell(Text(product.key, style: TextStyle(color: cWhite))),
                            DataCell(Text(product.value.qty, style: TextStyle(color: cWhite))),
                            DataCell(Text(product.value.price, style: TextStyle(color: cWhite))),
                            DataCell(Text('N/A', style: TextStyle(color: cWhite))), // Add a 'printed' field to your OrderModel if needed
                          ],
                        );
                      }).toList();
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        )
      ),
    );
  }
}