import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/ScrollableWidget.dart';
import '../constants/colors.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            builder: (context,value,child) {
              return InkWell(onTap: () {
                value.salesReport(context);
                      },
                child: Icon(Icons.calendar_month_outlined,size: 35,));
            }
          ),SizedBox(width: 10,)],

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
                          child:  Flexible(
                            fit: FlexFit.tight,
                            child: ScrollableWidget(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20), // Add border radius
                                  border: Border.all(color: cWhite, width: .8),
                                ),
                                child: Consumer<Mainprovider>(
                                    builder: (context,value,child) {
                                      return Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: DataTable(
                                            headingRowColor: MaterialStatePropertyAll(Colors.white),
                                            columnSpacing: 30,
                                            dataRowHeight: 90,
                                            border: TableBorder.all(
                                              color: Colors.yellow,
                                              width: 3,
                                            ),
                                            columns: const <DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Date & Time',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Items Name',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Qty',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  "Price",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),   DataColumn(
                                                label: Text(
                                                  "Printed",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),

                                            ],
                                            rows: value.Juiceshakesalllist.map((data) {
                                              return

                                                DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(
                                                      Text(data.categoryname,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),

                                                    ),
                                                    DataCell(
                                                      Text(data.name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),
                                                    ),
                                                    DataCell(

                                                      Text(data.price,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),
                                                    ),
                                                    DataCell(
                                                      Text(data.price,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),

                                                    ), DataCell(
                                                      Text("Yes6",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: cWhite),),

                                                    ),

                                                  ],

                                                );
                                            }).toList()),
                                      );

                                    }
                                ),
                              ),
                            ),
                          ),
                ),

    );
  }

}
