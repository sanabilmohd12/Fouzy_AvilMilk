//
// import 'package:flutter/material.dart';
// import 'package:fouzy/provider/mainprovider.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/colors.dart';
// import '../modelClass/oderModel.dart';
//
// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime day = DateTime.now();
//     DateTime onlyDate = DateTime(day.year, day.month, day.day);
//     DateTime endDate2 = onlyDate.add(const Duration(hours: 23, seconds: 59, minutes: 59));
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: cYellow,
//       appBar: AppBar(
//         title: const Text("ORDER SUMMARY",
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
//         child: Consumer<Mainprovider>(
//           builder: (context, provider, child) {
//             if (provider.orderList.isEmpty) {
//               return const Center(child: Text('No orders found'));
//             }
//             return Padding(
//               padding: EdgeInsets.only(bottom: 100.0),
//               child: ListView.builder(
//                 itemCount: provider.orderList.length,
//                 itemBuilder: (context, index) {
//                   OrderModel order = provider.orderList[index];
//                   return  Text("kjhgfdcvbnm,");
//                     ExpansionTile(
//                     backgroundColor: cYellow,
//                     collapsedBackgroundColor: Colors.white,
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Date: ${order.orderDate}'),
//                         Text('Total: ${order.totalAmount}'),
//                         Text('Order Type: ${order.orderType}'),
//                       ],
//                     ),
//                     children: [
//                       ListTile(title: Text('Order ID: ${order.orderId}')),
//                       ListTile(title: Text('Customer: ${order.customerName}')),
//                       ListTile(title: Text('Date: ${order.orderDate}')),
//                       ListTile(title: Text('Table: ${order.tableNo}')),
//                       ListTile(title: Text('Invoice: ${order.invoiceNo}')),
//                       ListTile(title: Text('Total: ${order.totalAmount}')),
//                       // Display products
//                       ...order.products.entries.map((entry) {
//                         String productName = entry.key;
//                         ProductModel product = entry.value;
//                         return ExpansionTile(
//                           title: Text(productName),
//                           children: [
//                             ListTile(title: Text('Quantity: ${product.qty}')),
//                             ListTile(title: Text('Price: ${product.price}')),
//                             ListTile(title: Text('Item Total: ${product.itemTotal}')),
//                           ],
//                         );
//                       }).toList(),
//                     ],
//                   );
//                 },
//               ),
//             );
//           },
//         )
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../modelClass/oderModel.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cYellow,
      appBar: AppBar(
        title: const Text("ORDER SUMMARY",
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
        child:  SingleChildScrollView(
          child: Column(
            children: [
              Consumer<Mainprovider>(
                builder: (context, provider, child) {
                  return provider.orderLoader?Center(child: CircularProgressIndicator(color: Colors.green,)): provider.orderList.length>0?Padding(
                    padding: EdgeInsets.all(18),
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.orderList.length,
                      itemBuilder: (context, index) {
                        OrderModel order = provider.orderList[index];
                        return Container(
                          decoration: BoxDecoration(color: lgtGrey,borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ExpansionTile(
                            backgroundColor: lgtGrey,
                            // collapsedBackgroundColor: Colors.white,
                            title: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                          width: 100,
                                          child: Text('Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12))),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(' : '+order.orderDate,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),),
                                    ],
                                  ),  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                          width: 100,
                                          child: Text('Total Amount',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12))),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(' : '+order.totalAmount,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                          width: 100,
                                          child: Text('Order Type',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12))),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(' : '+order.orderType,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),),
                                    ],
                                  ), Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                          width: 100,
                                          child: Text('Customer',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12))),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(' : '+order.customerName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),),
                                    ],
                                  ),
          
                                  Center(child: Text("view More",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.w600,fontSize: 16),))
          
          
                                ],
                              ),
                            ),
          
                            children: [
          
                              // Display products
                              ...order.products.entries.map((entry) {
                                String productName = entry.key;
                                ProductModel product = entry.value;
                                return ExpansionTile(
                                  title: Text(productName,style: TextStyle(color: cgreen,fontWeight: FontWeight.w600,fontSize: 16),),
                                  children: [
                                    ListTile(title: Text('Quantity: ${product.qty}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),)),
                                    ListTile(title: Text('Price: ${product.price}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),)),
                                    ListTile(title: Text('Item Total: ${product.itemTotal}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14),)),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    ),
                  ):Center(child: Text("No orders found",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 18)));
                },
              ),
            ],
          ),
        )
      ),
    );
  }}
