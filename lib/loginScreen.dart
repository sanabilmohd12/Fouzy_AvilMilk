import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'adminview/AdminHomeScreen.dart';
import 'constants/colors.dart';
import 'constants/myimages.dart';
import 'constants/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterFloat,
        // floatingActionButton: SizedBox(
        //   height: 49,
        //   width: width / 1.1,
        //   child: Consumer<Mainprovider>(builder: (context, value, child) {
        //     return FloatingActionButton(
        //       onPressed: () {
        //         if (value.loginCT.text == "696969") {
        //           callNextReplacement(context, Admin_Home_Screen());
        //         } else {
        //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //             backgroundColor: cWhite,
        //             content: Text("Incorrect Code",
        //                 style: TextStyle(
        //                   color: cgreen,
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.w800,
        //                 )),
        //             duration: Duration(milliseconds: 3000),
        //           ));
        //         }
        //       },
        //       elevation: 0,
        //       backgroundColor: cgreen,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(42),
        //       ),
        //       child: text(
        //         "LOGIN",
        //         FontWeight.w700,
        //         cWhite,
        //         18,
        //       ),
        //     );
        //   }),
        // ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: height / 40.0),
                child: Image.asset(
                  'assets/fouzylogo.png',
                  scale: 4,
                ),
              ),
              Text(
                "ADMIN",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Consumer<Mainprovider>(builder: (context, value, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: height / 12,
                  ),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xff19981CFF),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                      controller: value.loginCT,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        suffixIcon: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, top: 20),
                          child: Icon(
                            Icons.login,
                            color: cgreen,
                            size: 30,
                          ),
                        ),
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        helperText: "",
                        hintText: "Password",
                        hintStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          color: Color(0xc5025703),
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: EdgeInsets.only(left: 20, top: 20),
                        isDense: true,
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter your code";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child:
                    Consumer<Mainprovider>(builder: (context, value, child) {
                  return SizedBox(
                    width: height / 3.5,
                    height: height / 16,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Adjust as needed
                        ),
                      ),
                      onPressed: () {
                        if (value.loginCT.text == "123456") {
                          callNextReplacement(context, Admin_Home_Screen());
                          value.loginCT.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Center(
                              child: Text("Incorrect Code",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                            duration: Duration(milliseconds: 3000),
                          ));
                        }
                      },
                      child: Shimmer(
                        gradient: LinearGradient(colors: [
                          cgreen,
                          cYellow,
                          cgreen,
                        ]),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff22ab24), cgreen],
                              // Change colors as desired
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                15), // Match the button's shape
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: text(
                              "LOGIN",
                              FontWeight.w700,
                              cWhite,
                              18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
