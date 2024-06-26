

import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fouzy/constants/colors.dart';

import '../modelClass/MainCategoryModelClass.dart';

class Mainprovider extends  ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Reference ref = FirebaseStorage.instance.ref("IMAGE URL");



  /// maincategory


  TextEditingController  addCategorynameCt =TextEditingController();

  bool loader=false;

  void addMainCategory( BuildContext context,String from,String oldId){
    loader=true;
    notifyListeners();
    String id =DateTime.now().millisecondsSinceEpoch.toString();
    Map<String ,dynamic> map = HashMap();
    map["MAIN_CATEGORY_NAME"]=addCategorynameCt.text;

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
    getMainCategoy();
    notifyListeners();
  }


  void MainCategoryclear(){
    addCategorynameCt.clear();
  }

  List<MainCategory> mainCategorylist=[];
  bool getloader= false;

  void getMainCategoy(){
    getloader=true;
    notifyListeners();
    db.collection("MAIN_CATEGORY").get().then((value) {
      if(value.docs.isNotEmpty){
        getloader=false;
        notifyListeners();
        mainCategorylist.clear();
        for(var element in value.docs){
          Map<dynamic, dynamic> getmap = element.data();
          mainCategorylist.add(MainCategory(
            getmap["MAIN_CATEGORY_ID"].toString(),
            getmap["MAIN_CATEGORY_NAME"].toString(),
          ));
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void deletemaincategory(String id){
    db.collection("MAIN_CATEGORY").doc(id).delete();
    getMainCategoy();
    notifyListeners();
  }

  void editmaincategory(String id) {
    db.collection('MAIN_CATEGORY').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        addCategorynameCt.text = dataMaps["MAIN_CATEGORY_NAME"].toString();
      }
      notifyListeners();
    });
    notifyListeners();
  }

                            // Avilmilks


     TextEditingController avilMilkNameCt =TextEditingController();
     TextEditingController avilMilkPriceCt =TextEditingController();
     TextEditingController avilMilkDescribtionCt =TextEditingController();
     TextEditingController avilMilkCategoryCt =TextEditingController();
     TextEditingController maincategorynameCt =TextEditingController();

     String mainCategorySelectedId ='';

     bool avilloader=false;
      File? AvilmilkFileImg=null;
      String avilmilkimg='';

  Future<void> addAvilMilkItems( BuildContext context,String from,String oldId) async {
    avilloader=true;
    notifyListeners();
    String id =DateTime.now().millisecondsSinceEpoch.toString();
    Map<String ,dynamic> map = HashMap();
    map["AVIL_MILK_NAME"]=avilMilkNameCt.text;
    map["AVIL_MILK_PRICE"]=avilMilkPriceCt.text;
    map["DISCRETION"]=avilMilkDescribtionCt.text;
    map["AVILMILK_CATEGORY"]=avilMilkCategoryCt.text;
    map["MAIN_CATEGORY"]=maincategorynameCt.text;

    if (AvilmilkFileImg != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(AvilmilkFileImg!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          map["AVILMILK_PHOTO"] = value;

          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      map['AVILMILK_PHOTO'] = avilmilkimg;
    }



    if(from=="NEW"){
      map["AVIL_MILK_ID"]=id;
    }

    if(from=="EDIT"){
      db.collection("AVIL_MILK").doc(oldId).update(map);
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(
        backgroundColor: cWhite,
        content: Text(
            "Updated Successfully",style: TextStyle(color: cgreen,fontSize: 20,fontWeight: FontWeight.w800,)),
        duration:
        Duration(milliseconds: 3000),
      ));
    }else{
      db.collection("AVIL_MILK").doc(id).set(map);
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(
        backgroundColor: cWhite,
        content: Text(
            "Added Successfully",style: TextStyle(color: cgreen,fontSize: 20,fontWeight: FontWeight.w800,)),
        duration:
        Duration(milliseconds: 3000),
      ));
    }
    avilloader=false;

    notifyListeners();
  }




}