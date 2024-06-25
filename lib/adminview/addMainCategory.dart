import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';

class addMainCategoryScreen extends StatelessWidget {
   addMainCategoryScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            appbarbkgd,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: SizedBox(
          height: 49,
          width: width / 1.1,
          // child: Consumer<MainProvider>(builder: (context, value, child) {
          //   return   value.loader?CircularProgressIndicator(color: tViloet,):
            child: FloatingActionButton(
              onPressed: () {
                // final FormState? form = _formKey.currentState;
                // if (form!.validate()) {

                  // if(from=="NEW"){
                  //   value.addDetails(from,"");
                  //
                  //   value.getdetails();
                  //   back(context);
                  // }else{
                  //   value.addDetails(from,oldid);
                  //
                  //   value.getdetails();
                  //   back(context);
                  // }
              //
              //   }
                back(context);

              },
              elevation: 0,
              backgroundColor: cgreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              child: text(
                "Save",
                FontWeight.w700,
                cWhite,
                18,
              ),
            )
          // }),
        ),

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              back(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: cgreen,
              size: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,

          title: text(
            "Add MainCategory",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  SizedBox(height: height*0.2,),
                textfield(
                    TextInputType.text, "enter your Types ", "Types"),
              ],
            ),
          ),
        ) ,


      ),
    );
  }
}
