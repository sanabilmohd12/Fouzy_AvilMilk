

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fouzy/constants/colors.dart';

class Mainprovider extends  ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Reference ref = FirebaseStorage.instance.ref("IMAGE URL");



  //  add fun for maincategory


  TextEditingController  addCategoryCt =TextEditingController();

  bool loader=false;

  void addMainCategory( BuildContext context,String from,String oldId){
    loader=true;
    notifyListeners();
    String id =DateTime.now().millisecondsSinceEpoch.toString();
    Map<String ,dynamic> map = HashMap();
    map["MAIN_CATEGORY_NAME"]=addCategoryCt.text;

    if(from=="NEW"){
      map["MAIN_CATEGORY_ID"]=id;
    }

    if(from=="EDIT"){
      db.collection("MAIN_CATEGORY").doc(oldId).update(map);
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(
        backgroundColor: cWhite,
        content: Text(
            "Updated Successfully",style: TextStyle(color: cgreen,fontSize: 20,fontWeight: FontWeight.w800,)),
        duration:
        Duration(milliseconds: 3000),
      ));
    }else{
      db.collection("MAIN_CATEGORY").doc(id).set(map);
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(
        backgroundColor: cWhite,
        content: Text(
            "Added Successfully",style: TextStyle(color: cgreen,fontSize: 20,fontWeight: FontWeight.w800,)),
        duration:
        Duration(milliseconds: 3000),
      ));
    }
    loader=false;
    notifyListeners();
  }

}