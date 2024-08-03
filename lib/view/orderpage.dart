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
//
//     int selectedContainerIndex=0;
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: cYellow,
//       appBar: AppBar(
//         title: const Text("ORDER SUMMERY",
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
//       body:
//
//       Container(
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
//         // child: StreamBuilder<List<OrderModel>>(
//         //       stream: Provider.of<Mainprovider>(context, listen: false).fetchOrderList(),
//         //       builder: (context, snapshot) {
//         //         if (snapshot.connectionState == ConnectionState.waiting) {
//         //           return Center(child: CircularProgressIndicator());
//         //         } else if (snapshot.hasError) {
//         //           return Center(child: Text('Error: ${snapshot.error}'));
//         //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         //           return Center(child: Text('No orders found'));
//         //         } else {
//         //           return Padding(
//         //             padding:  EdgeInsets.only(bottom: 100.0),
//         //             child: ListView.builder(
//         //               itemCount: snapshot.data!.length,
//         //               itemBuilder: (context, index) {
//         //                 OrderModel order = snapshot.data![index];
//         //                 ExpansionTile(title: Text('Customer: ${order.customerName}')
//         //                 );
//         //
//         //
//         //
//         //               },
//         //             ),
//         //           );
//         //
//         //
//         //         }
//         //       },
//         //     ),
//
//
//
//
//
//       ),
//
//     );
//   }
//
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
    DateTime day = DateTime.now();
    DateTime onlyDate = DateTime(day.year, day.month, day.day);
    DateTime endDate2 = onlyDate.add(const Duration(hours: 23, seconds: 59, minutes: 59));
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
        child: FutureBuilder<void>(
          future: Provider.of<Mainprovider>(context, listen: false).fetchOrderList(onlyDate,endDate2),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return  Consumer<Mainprovider>(
                builder: (context, provider, child) {
                  if (provider.orderList.isEmpty) {
                    return const Center(child: Text('No orders found'));
                  }
                  return Padding(
                    padding: EdgeInsets.only(bottom: 100.0),
                    child: ListView.builder(
                      itemCount: provider.orderList.length,
                      itemBuilder: (context, index) {
                        OrderModel order = provider.orderList[index];
                        return ExpansionTile(
                          backgroundColor: cYellow,
                          collapsedBackgroundColor: Colors.white,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${order.orderDate}'),
                              Text('Total: ${order.totalAmount}'),
                              Text('Order Type: ${order.orderType}'),
                            ],
                          ),
                          children: [
                            ListTile(title: Text('Order ID: ${order.orderId}')),
                            ListTile(title: Text('Customer: ${order.customerName}')),
                            ListTile(title: Text('Date: ${order.orderDate}')),
                            ListTile(title: Text('Table: ${order.tableNo}')),
                            ListTile(title: Text('Invoice: ${order.invoiceNo}')),
                            ListTile(title: Text('Total: ${order.totalAmount}')),
                            // Display products
                            ...order.products.entries.map((entry) {
                              String productName = entry.key;
                              ProductModel product = entry.value;
                              return ExpansionTile(
                                title: Text(productName),
                                children: [
                                  ListTile(title: Text('Quantity: ${product.qty}')),
                                  ListTile(title: Text('Price: ${product.price}')),
                                  ListTile(title: Text('Item Total: ${product.itemTotal}')),
                                ],
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}