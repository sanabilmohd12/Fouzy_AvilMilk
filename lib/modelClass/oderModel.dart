// orderModel.dart
class OrderModel {
  final String orderId;
  final String customerName;
  final String orderDate;
  final String orderType;
  final String tableNo;
  final String invoiceNo;
  final List <ProductModel> products;
  final String totalAmount;

  OrderModel({
    required this.orderId,
    required this.customerName,
    required this.orderDate,
    required this.orderType,
    required this.tableNo,
    required this.invoiceNo,
    required this.products,
    required this.totalAmount,
  });



// factory OrderModel.fromMap(Map<String, dynamic> map) {
//   return OrderModel(
//     orderId: map['ORDER_ID'] ?? '',
//     customerName: map['CUSTOMER_NAME'] ?? '',
//     orderDate: map['ORDER_DATE'] ?? '',
//     orderType: map['ORDER_TYPE'] ?? '',
//     tableNo: map['TABLE_NO'] ?? '',
//     invoiceNo: map['INVOICE_NO'] ?? '',
//     products: (map['PRODUCTS'] as Map<String, dynamic>).map(
//           (key, value) => MapEntry(key, ProductModel.fromMap(value as Map<String, dynamic>)),
//     ),
//     totalAmount: map['TOTAL_AMOUT'] ?? '',
//   );
// }
}

class ProductModel {
  final String name;
  final String qty;
  final String price;
  final String itemTotal;

  ProductModel({
    required this.name,
    required this.qty,
    required this.price,
    required this.itemTotal,
  });

// factory ProductModel.fromMap(Map<String, dynamic> map) {
//
//   return ProductModel(
//     qty: map['Qty'].toString(),
//     price: map['Price'].toString(),
//     itemTotal: map['Item Total'].toString(),
//   );
// }

}
  class SalesReportOrder{
  String id;
  String custnmame;
  String invoicenumber;
  String orderdate;
  String ordertype;
  String tabelnumber;
  String totalamount;
  SalesReportOrder(this.id,this.custnmame,this.invoicenumber,this.orderdate,this.ordertype,this.tabelnumber,this.totalamount);
  }

