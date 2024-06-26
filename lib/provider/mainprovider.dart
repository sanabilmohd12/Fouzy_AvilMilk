



import 'dart:collection';

import 'package:flutter/cupertino.dart';

class Mainprovider extends ChangeNotifier{

Future<void>addItems()async{
  String id = DateTime.now().millisecondsSinceEpoch.toString();
HashMap<String,Object> map = HashMap();
  map["USER_ID"] = id;
}
  
}