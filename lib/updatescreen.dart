import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {
  String text;
  String button;
  String ADDRESS;
  UpdateScreen({Key? key,required this.text,required this.button,required this.ADDRESS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    return  WillPopScope(
      onWillPop: () async => false,

      child: Container(
        width: width,
        height: hieght,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/bgimg.jpeg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:  const BoxDecoration(
                color: Colors.transparent

            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 50),

                  decoration:  BoxDecoration(

                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(text,style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.w800),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: (){
                      _launchURL(ADDRESS);
                    },
                    child: Container(
                      height: 43,
                      width: 150,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(button,style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Image.asset("assets/logo.png",scale:3),
          //     ],
          //   ),
          // ),


        ),
      ),
    );

  }
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
