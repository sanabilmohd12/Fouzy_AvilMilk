import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

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
            return
            FloatingActionButton(
              onPressed: () {

               if(value.loginCT.text=="696969"){
                 callNextReplacement(context, Admin_Home_Screen());
               }else{
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                   backgroundColor: cWhite,
                   content: Text("Incorrect Code",
                       style: TextStyle(
                         color: cgreen,
                         fontSize: 15,
                         fontWeight: FontWeight.w800,
                       )),
                   duration: Duration(milliseconds: 3000),
                 ));
               }
              },
              elevation: 0,
              backgroundColor: cgreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              child: text(
                "LOGIN",
                FontWeight.w700,
                cWhite,
                18,
              ),
            );
          }),
        ),
        backgroundColor: Colors.transparent,
        body:Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN"),
            Consumer<Mainprovider>(
                builder: (context,value,child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 120,

                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],

                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),

                        textAlign: TextAlign.center,
                        controller: value.loginCT,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                          helperText: "",
                          labelText: "LOGIN",
                          labelStyle: TextStyle(fontSize: 18),


                          hintStyle: TextStyle(color: Colors.grey[400]),
                          // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:  BorderSide(
                              color: cWhite,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:  BorderSide(
                              color:cWhite,
                              width: 1,
                            ),
                          ),
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

                }
            ),
          ],
        ) ,



      ),
    );
  }

}
