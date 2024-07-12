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
                          child:  Flexible(
                            fit: FlexFit.tight,
                            child: ScrollableWidget(
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20), // Add border radius
                                  border: Border.all(color: cWhite, width: .8),
                                ),
                                child: Consumer<Mainprovider>(
                                    builder: (context,value,child) {
                                      return DataTable(
                                          headingRowColor: MaterialStatePropertyAll(
                                              Color(0xffF6DDF8).withOpacity(.5)),


                                          columnSpacing: 30,
                                          dataRowHeight: 90,
                                          border: TableBorder.all(
                                            color: cWhite,
                                            width: .9,
                                          ),
                                          columns: const <DataColumn>[
                                            DataColumn(
                                              label: Text(
                                                'Route Name',
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
                                                'Starting Location ',
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
                                                'Ending Location',
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
                                                '',
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
                                                      InkWell(onTap: (){
                                                        // deleteAlert(context, data.id);

                                                      },
                                                          child: Icon(Icons.delete,color: Colors.red,))
                                                  ),

                                                ],

                                              );
                                          }).toList());

                                    }
                                ),
                              ),
                            ),
                          ),
                ),

    );
  }

}
