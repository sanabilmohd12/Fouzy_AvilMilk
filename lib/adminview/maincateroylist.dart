import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/mainprovider.dart';
import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import 'addMainCategory.dart';

class Main_Category extends StatelessWidget {
  const Main_Category({super.key});

  // Future<void> _loadData(BuildContext context) async {
  //   final provider = Provider.of<Mainprovider>(context, listen: false);
  //   await provider.getMainCategoy(); // Assume this method exists to fetch data
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(appbarbkgd),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        floatingActionButton: Consumer<Mainprovider>(
          builder: (context, value, child) {
            return FloatingActionButton(
              backgroundColor: cgreen,
              child: Icon(Icons.add, color: cWhite, size: 38),
              onPressed: () {
                value.MainCategoryclear();
                callNext(context, addMainCategoryScreen(from: "NEW", oldid: ""));
              },
            );
          },
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => back(context),
            child: Icon(Icons.arrow_back_ios, color: cgreen, size: 24),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: text("Main Category", FontWeight.w700, cgreen, 18),
        ),
        body: Consumer<Mainprovider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.mainCategorylist.length,
                itemBuilder: (context, index) {
                  var items = value.mainCategorylist[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: width,
                    height: height * .12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cWhite,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: FittedBox(child: text(items.name, FontWeight.w800, cgreen, 20))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => _showDeleteDialog(context, value, items.id),
                                  child: btn(20, 60, cWhite, "Delete", myRed, FontWeight.w500, 12, Icons.delete_outline),
                                ),
                                InkWell(
                                  onTap: () => _showEditDialog(context, value, items.id),
                                  child: btn(20, 60, cWhite, "Edit", cgreen, FontWeight.w500, 12, Icons.edit_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        )
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Mainprovider value, String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Do you want to DELETE ?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: cBlack)),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                value.deletemaincategory(itemId, context);
                Navigator.of(context).pop();
              },
              child: Container(
                height: 45,
                width: 90,
                decoration: BoxDecoration(
                  color: myRed,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Color(0x26000000), blurRadius: 2.0, spreadRadius: 1.0)],
                ),
                child: Center(child: Text("Delete", style: TextStyle(color: cWhite, fontSize: 17, fontWeight: FontWeight.w700))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Mainprovider value, String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Do you want to EDIT ?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: cBlack)),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                value.editmaincategory(itemId, context);
                callNext(context, addMainCategoryScreen(from: "EDIT", oldid: itemId));
              },
              child: Container(
                height: 45,
                width: 90,
                decoration: BoxDecoration(
                  color: cgreen,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Color(0x26000000), blurRadius: 2.0, spreadRadius: 1.0)],
                ),
                child: Center(child: Text("Edit", style: TextStyle(color: cWhite, fontSize: 17, fontWeight: FontWeight.w700))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}