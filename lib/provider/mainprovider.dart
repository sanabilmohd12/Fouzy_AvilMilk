

import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../modelClass/MainCategoryModelClass.dart';
import '../modelClass/avilmilktypesModelClass.dart';

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

                            /// Avilmilks


     TextEditingController avilMilkNameCt =TextEditingController();
     TextEditingController avilMilkPriceCt =TextEditingController();
     TextEditingController avilMilkDescribtionCt =TextEditingController();
     TextEditingController avilMilkCategoryCt =TextEditingController();
     TextEditingController maincategorynameCt =TextEditingController();

     String mainCategorySelectedId ='';

     bool avilloader=false;
      File? AvilmilkFileImg=null;
      String avilmilkimg='';

  Future<void> addAvilMilkItems( BuildContext context1,String from,String oldId) async {
    avilloader=true;
    notifyListeners();
    String id =DateTime.now().millisecondsSinceEpoch.toString();
    Map<String ,dynamic> map = HashMap();
    map["AVIL_MILK_NAME"]=avilMilkNameCt.text;
    map["AVIL_MILK_PRICE"]=avilMilkPriceCt.text;
    map["DISCRETION"]=avilMilkDescribtionCt.text;
    map["AVILMILK_CATEGORY"]=avilMilkCategoryCt.text;
    map["MAIN_CATEGORY"]=maincategorynameCt.text;
    map["MAIN_CATEGORY_ID"]=mainCategorySelectedId;
    map["ADDED_TIME"]=DateTime.now();
    map["COUNT"]="";

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
      ScaffoldMessenger.of(context1)
          .showSnackBar( SnackBar(
        backgroundColor: cWhite,
        content: Text(
            "Updated Successfully",style: TextStyle(color: cgreen,fontSize: 20,fontWeight: FontWeight.w800,)),
        duration:
        Duration(milliseconds: 3000),
      ));
    }else{
      db.collection("AVIL_MILK").doc(id).set(map);
      ScaffoldMessenger.of(context1)
          .showSnackBar( SnackBar(
             backgroundColor: cWhite,
        content: Text(
            "Added Successfully",style: TextStyle(color: cgreen,fontSize: 20,fontWeight: FontWeight.w800,)),
        duration:
        Duration(milliseconds: 3000),
      ));
    }
    avilloader=false;
    getavilmilktypes();
    notifyListeners();
  }
  void setImage(File image) {
    AvilmilkFileImg = image;
    notifyListeners();
  }

  Future getImggallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  Future getImgcamera() async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  // Future<void> cropImage(String path, String from) async {
  //   final croppedFile = await ImageCropper().cropImage(
  //     sourcePath: path,
  //     aspectRatioPresets: Platform.isAndroid
  //         ? [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9,
  //     ]
  //         : [
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio5x3,
  //       CropAspectRatioPreset.ratio5x4,
  //       CropAspectRatioPreset.ratio7x5,
  //       CropAspectRatioPreset.ratio16x9,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Colors.white,
  //           toolbarWidgetColor: Colors.black,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       )
  //     ],
  //   );
  //   if (croppedFile != null) {
  //     Registerfileimg = File(croppedFile.path);
  //     notifyListeners();
  //   }
  // }


   void avilmilkclear(){
    avilMilkNameCt.clear();
    avilMilkPriceCt.clear();
    avilMilkDescribtionCt.clear();
    avilMilkCategoryCt.clear();
    mainCategorylist.clear();
    avilmilkimg='';
    AvilmilkFileImg=null;
   }


 List<AvilMilkTypes> avilmilklist=[];


  bool getavilloader= false;

  void getavilmilktypes(){
    getavilloader=true;
    notifyListeners();
    db.collection("AVIL_MILK").get().then((value) {
      if(value.docs.isNotEmpty){
        getavilloader=false;
        notifyListeners();
        avilmilklist.clear();
        for(var element in value.docs){
          Map<dynamic, dynamic> getavilmap = element.data();
          avilmilklist.add(AvilMilkTypes(
              getavilmap["AVIL_MILK_ID"].toString(),
              getavilmap["AVIL_MILK_NAME"].toString(),
              getavilmap["AVIL_MILK_PRICE"].toString(),
              getavilmap["DISCRETION"].toString(),
              getavilmap["AVILMILK_CATEGORY"].toString(),
              getavilmap["MAIN_CATEGORY"].toString(),
              getavilmap["MAIN_CATEGORY_ID"].toString(),
              getavilmap["AVILMILK_PHOTO"].toString(),

            ));
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void deleteavilmilk(String id){
    db.collection("AVIL_MILK").doc(id).delete();
    getavilmilktypes();
    notifyListeners();
  }

  void editavilmilk(String id) {
    db.collection('AVIL_MILK').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        avilMilkNameCt.text=dataMaps["AVIL_MILK_NAME"].toString();
        avilMilkPriceCt.text=dataMaps["AVIL_MILK_PRICE"].toString();
        avilMilkDescribtionCt.text=dataMaps["DISCRETION"].toString();
        avilMilkCategoryCt.text=dataMaps["AVILMILK_CATEGORY"].toString();
        maincategorynameCt.text=dataMaps["MAIN_CATEGORY"].toString();
        avilmilkimg=dataMaps["AVILMILK_PHOTO"].toString();
      }
      notifyListeners();
    });
    notifyListeners();
  }

                      // jucie & shakes


  TextEditingController juciecategoryCt =TextEditingController();


  bool jucieloader=false;

  void addJucieCategory( BuildContext context,String from,String oldId){
    jucieloader=true;
    notifyListeners();
    String id =DateTime.now().millisecondsSinceEpoch.toString();
    Map<String ,dynamic> map = HashMap();
    map["JUICE_CATEGORY_NAME"]=juciecategoryCt.text;

    if(from=="NEW"){
      map["JUICE_CATEGORY_ID"]=id;
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
    jucieloader=false;
    getMainCategoy();
    notifyListeners();
  }

}