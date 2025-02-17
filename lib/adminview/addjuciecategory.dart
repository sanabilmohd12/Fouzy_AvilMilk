import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import '../modelClass/MainCategoryModelClass.dart';

class AddJucieCategory extends StatelessWidget {
  String juicefrom;
  String jucieoldid;

  AddJucieCategory({super.key,required this.juicefrom,required this.jucieoldid});

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
            child: Consumer<Mainprovider>(builder: (context, value, child) {
              return   value.jucieloader?CircularProgressIndicator(color: cgreen,):
            FloatingActionButton(
              onPressed: () {
                final FormState? form = _formKey.currentState;
                if (form!.validate()) {

                if(juicefrom=="NEW"){
                  value.addJucieCategory(context,juicefrom,"");

                  back(context);
                }else{
                  value.addJucieCategory(context,juicefrom,jucieoldid);

                  back(context);
                }

                  }

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
            );
          }),
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
            "Add Fouzy Jucies Types",
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
                Consumer<Mainprovider>(
                  builder: (context,value,child) {
                    return textfield(
                        TextInputType.text, "enter your juice Category ", "Category",value.juciecategoryCt);

                  }
                ),

              ],
            ),
          ),
        ) ,


      ),
    );
  }
}
