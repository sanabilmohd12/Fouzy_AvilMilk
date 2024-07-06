import 'package:flutter/material.dart';

class Detailsscreen extends StatelessWidget {
  final String  id;

   Detailsscreen({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: Text('Details for item $id'),
      ),
    );
  }
}
