import 'package:flutter/material.dart';
import 'package:fouzy/constants/colors.dart';

import 'bottombar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cYellow,
      appBar: AppBar(
        toolbarHeight: 150,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appbar bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Stack(
        children:[

        SingleChildScrollView(
          child: Column(
            children: [

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
                child: ListView.builder(
                  shrinkWrap: true,

                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 28),
                      child: Container(
                        height: height / 12,
                        width: width * .2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: syellow,
                          image:const DecorationImage(
                            image: AssetImage(
                              'assets/containerimg.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Avil Milk',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemSelected: _onItemTapped,
            ),
          ),
            ],
      ),

      // bottomNavigationBar: CustomBottomNavigationBar(
      //   selectedIndex: _selectedIndex,
      //   onItemSelected: _onItemTapped,
      // ),
    );
  }
}
