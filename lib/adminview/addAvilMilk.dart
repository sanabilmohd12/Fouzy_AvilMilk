import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';

class addAvilMilkScreen extends StatelessWidget {
  addAvilMilkScreen({super.key});

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
            "Add Fouzy AvilMilk",
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
                 Container(
                   margin:EdgeInsets.symmetric(horizontal: 10,vertical: 10) ,

                     width: 200,height: 200,
                   decoration: BoxDecoration(color: cWhite,borderRadius: BorderRadius.circular(15),boxShadow: [
                     BoxShadow(
                         color: lightWhite,
                         spreadRadius: 3,
                         blurStyle: BlurStyle.inner,blurRadius: 5

                     )],border: Border.all(width: 2,color: cWhite)),
                   child: Column(mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.add_a_photo_rounded,color: cgreen,size: 50,),
                       text("Add AvilMilk Images", FontWeight.w400, cgreen, 12)
                     ],
                   ),
                 ),
                SizedBox(height: 50),

                // textfield(
                //     TextInputType.text, "enter your AvilMilk Name ", "Name"),
                // textfield(
                //     TextInputType.number, "enter your Price", " ₹Price"),
                // textfield(
                //     TextInputType.text, "enter your description ", "description"),
                // textfield(
                //     TextInputType.text, "enter your AvilMilk Category ", "AvilMilk Category"),
                // /// autocomplete maincategory
                // textfield(
                //     TextInputType.text, "enter your Types ", "Types",""),

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




                savebtn(height/15, width, cgreen, "Save", cWhite, FontWeight.w800, 15)

              ],
            ),
          ),
        ) ,


      ),
    );
  }
}
