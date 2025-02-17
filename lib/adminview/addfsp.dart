import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import '../modelClass/MainCategoryModelClass.dart';

class AddFouzySpecials extends StatelessWidget {
  String fspavilfrom;
  String fspaviloldid;
  AddFouzySpecials({
    super.key,
    required this.fspavilfrom,
    required this.fspaviloldid,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
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
            "Add Fouzy Seasonal",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<Mainprovider>(builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      showBottomSheet(context);
                    },
                    child: value.fspAvilmilkFileImg != null
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                color: cWhite,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: lightWhite,
                                      spreadRadius: 3,
                                      blurStyle: BlurStyle.inner,
                                      blurRadius: 5)
                                ],
                                border: Border.all(width: 2, color: cWhite),
                                image: DecorationImage(
                                    image:
                                        FileImage(value.fspAvilmilkFileImg!))),
                          )
                        : value.fspAvilmilkImg != ""
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: cWhite,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: lightWhite,
                                          spreadRadius: 3,
                                          blurStyle: BlurStyle.inner,
                                          blurRadius: 5)
                                    ],
                                    border: Border.all(width: 2, color: cWhite),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            value.fspAvilmilkImg))),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: cWhite,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: lightWhite,
                                          spreadRadius: 3,
                                          blurStyle: BlurStyle.inner,
                                          blurRadius: 5)
                                    ],
                                    border:
                                        Border.all(width: 2, color: cWhite)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_rounded,
                                      color: cgreen,
                                      size: 50,
                                    ),
                                    text("Add AvilMilk Images", FontWeight.w400,
                                        cgreen, 12)
                                  ],
                                ),
                              ),
                  );
                }),
                // SizedBox(height: 50),

                Consumer<Mainprovider>(builder: (context, value, child) {
                  return textfield(TextInputType.text,
                      "enter your AvilMilk Name ", "Name", value.fspNameCt);
                }),
                Consumer<Mainprovider>(builder: (context, value, child) {
                  return textfield(TextInputType.number, "enter your Price",
                      " ₹Price", value.fspPriceCt);
                }),
                Consumer<Mainprovider>(builder: (context, value, child) {
                  return textfield(
                      TextInputType.text,
                      "enter your description ",
                      "description",
                      value.fspDescriptionCt);
                }),
                Consumer<Mainprovider>(builder: (context, value, child) {
                  return textfield(
                      TextInputType.text,
                      "enter your AvilMilk Category ",
                      "AvilMilk Category",
                      value.fspCategoryCt);
                }),

                /// autocomplete maincategory
                ///
                 Consumer<Mainprovider>(builder: (context, value, child) {
                  return InkWell(
                      onTap: () {
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          if (value.fspAvilmilkFileImg != null ||
                              value.fspAvilmilkImg != '') {
                            if (fspavilfrom == "NEW") {
                              value.addfspAvilMilk(context, fspavilfrom, "");

                              back(context);
                            } else {
                              value.addfspAvilMilk(
                                  context, fspavilfrom, fspaviloldid);

                              back(context);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    "product photo provide",
                                    style:
                                        TextStyle(color: cWhite, fontSize: 15),
                                  )),
                            );
                          }
                        }
                      },
                      child: savebtn(height / 15, width, cgreen, "Saved",
                          cWhite, FontWeight.w800, 15));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    Mainprovider provider = Provider.of<Mainprovider>(context, listen: false);
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.camera_enhance_sharp,
                    color: cgreen,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () =>
                      {provider.getImgcamerasf(), Navigator.pop(context)}),
              ListTile(
                  leading: Icon(Icons.photo, color: cgreen),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () =>
                      {provider.getImggalleryf(), Navigator.pop(context)}),
            ],
          );
        });
    // ImageSource
  }
 }
