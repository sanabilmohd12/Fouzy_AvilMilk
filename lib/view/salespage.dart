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
        child: SingleChildScrollView(
          child: Consumer<Mainprovider>(
            builder: (context, provider, child) {
              return  provider.getsalsesloader?Center(child: CircularProgressIndicator(color: Colors.green,)):
              provider.salesreportlist.length>0?ScrollableWidget(

                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: cWhite, width: .8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(Colors.white),
                        columnSpacing: 30,
                        dataRowHeight: 90,
                        border: TableBorder.all(
                          color: Colors.yellow,
                          width: 3,
                        ),
                        columns: const <DataColumn>[
                          DataColumn(label: Text('SL\n no', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                          DataColumn(label: Text('Date & Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                          DataColumn(label: Text('Invoice NO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                          DataColumn(label: Text('Total Amount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                          DataColumn(label: Text('Order Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                          DataColumn(label: Text('Printed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                        ],
                        rows: List<DataRow>.generate(
                          provider.salesreportlist.length,
                              (index) {
                            final data = provider.salesreportlist[index];
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text("${index + 1}", style: TextStyle(color: cWhite))),
                                DataCell(Text(data.orderdate, style: TextStyle(color: cWhite))),
                                DataCell(Text(data.invoicenumber, style: TextStyle(color: cWhite))),
                                DataCell(Text(data.totalamount, style: TextStyle(color: cWhite))),
                                DataCell(Text(data.ordertype, style: TextStyle(color: cWhite))),
                                DataCell(Text('N/A', style: TextStyle(color: cWhite))), // Add a 'printed' field to your OrderModel if needed
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ):Center(child: Text("Please select calender to know order details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 18)));

            },
          ),
        )
      ),
    );
  }
}