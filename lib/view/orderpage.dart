import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../modelClass/oderModel.dart';

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
        child: StreamBuilder<List<OrderModel>>(
          stream: Provider.of<Mainprovider>(context, listen: false).getOrdersStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No orders found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  OrderModel order = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: cWhite,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(3, 4),
                          blurRadius: 8,
                          spreadRadius: -1,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order ID: ${order.orderId}', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Customer: ${order.customerName}'),
                        Text('Date: ${order.orderDate}'),
                        Text('Type: ${order.orderType}'),
                        Text('Table: ${order.tableNo}'),
                        Text('Invoice: ${order.invoiceNo}'),
                        Text('Total: ${order.totalAmount}'),
                        SizedBox(height: 10),
                        Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...order.products.entries.map((entry) =>
                            Text('${entry.key}: Qty: ${entry.value.qty}, Price: ${entry.value.price}, Total: ${entry.value.itemTotal}')
                        ).toList(),
                      ],
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
