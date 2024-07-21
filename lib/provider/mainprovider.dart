import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:intl/intl.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:fouzy/view/flashsnackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../constants/callFunctions.dart';
import '../modelClass/MainCategoryModelClass.dart';
import '../modelClass/avilmilktypesModelClass.dart';
import '../modelClass/cartmodelclas.dart';
import '../modelClass/fouzysp.dart';
import '../modelClass/icecreamsModelClass.dart';
import '../modelClass/jucieandshakesCateModelClass.dart';
import '../updatescreen.dart';

class Mainprovider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Reference ref = FirebaseStorage.instance.ref("IMAGE URL");



  Mainprovider(){
    getAppVersion();
    notifyListeners();

  }


  /// bottomsheet indexes *
  int _selectedindex = 0;
  int get selectedindex => _selectedindex;

  void selectindex(int index) {
    _selectedindex = index;
    notifyListeners();
  }

  /// Count
  void countIncrement(int index) {
    if (index >= 0 && index < cartitemslist.length) {
      cartitemslist[index].count++;
      updateItemDetails(index);
      notifyListeners();
    }
  }

  void countDecrement(int index) {
    if (index >= 0 && index < cartitemslist.length && cartitemslist[index].count > 1) {
      cartitemslist[index].count--;
      updateItemDetails(index);
      notifyListeners();
    }
  }

  void updateItemDetails(int index) {
    double initialPrice = double.parse(cartitemslist[index].itemprice);
    double newPrice = initialPrice * cartitemslist[index].count;

    cartitemslist[index].totalprice = newPrice.toStringAsFixed(2);
    cartitemslist[index].qty = cartitemslist[index].count.toString();

    print("Item: ${cartitemslist[index].itemname}");
    print("Count: ${cartitemslist[index].count}");
    print("Qty: ${cartitemslist[index].qty}");
    print("Total Price: ${cartitemslist[index].totalprice}");
    notifyListeners();
  }

  ///
  Map<String, dynamic> cartItems = {};

  void cartItemsControlls(String collection, String firebaseId, dynamic item) {
    String key = "$collection:$firebaseId";
    if (cartItems.containsKey(key)) {
      cartItems.remove(key);
      print("Removed from cart: $key");
    } else {
      cartItems[key] = item;
      print("Added to cart: $key");
    }
    print("Current cart items: ${cartItems.length}");
    notifyListeners();
  }

  bool isInCart(String collection, String firebaseId) {
    String key = "$collection:$firebaseId";
    return cartItems.containsKey(key);
  }

  TextEditingController priceCt = TextEditingController();

  /// maincategory

  TextEditingController addCategorynameCt = TextEditingController();

  bool loader = false;

  void addMainCategory(BuildContext context, String from, String oldId) {
    loader = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> map = HashMap();
    map["MAIN_CATEGORY_NAME"] = addCategorynameCt.text;

    if (from == "NEW") {
      map["MAIN_CATEGORY_ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("MAIN_CATEGORY").doc(oldId).update(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Updated Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      db.collection("MAIN_CATEGORY").doc(id).set(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Added Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    }
    loader = false;
    getMainCategoy();
    notifyListeners();
  }

  void MainCategoryclear() {
    addCategorynameCt.clear();
  }

  List<MainCategory> mainCategorylist = [];

  bool getloader = false;

  void getMainCategoy() {
    print("ddcd");
    getloader = true;
    notifyListeners();
    db.collection("MAIN_CATEGORY").get().then((value) {
      if (value.docs.isNotEmpty) {
        getloader = false;
        notifyListeners();
        mainCategorylist.clear();
        for (var element in value.docs) {
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

  void deletemaincategory(String id, BuildContext context) {
    db.collection("MAIN_CATEGORY").doc(id).delete();
    getMainCategoy();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15),
          )),
    );
    notifyListeners();
  }

  void editmaincategory(String id, BuildContext context) {
    db.collection('MAIN_CATEGORY').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        addCategorynameCt.text = dataMaps["MAIN_CATEGORY_NAME"].toString();
      }
      notifyListeners();
    });

    notifyListeners();
  }

  ///FouzySp

  TextEditingController fspNameCt = TextEditingController();
  TextEditingController fspPriceCt = TextEditingController();
  TextEditingController fspDescriptionCt = TextEditingController();
  TextEditingController fspCategoryCt = TextEditingController();
  TextEditingController spmaincategorynameCt = TextEditingController();

  String fspmainCategorySelectedId = '';
  bool fsploader = false;
  File? fspAvilmilkFileImg = null;
  String fspAvilmilkImg = '';

  Future<void> addfspAvilMilk(
      BuildContext context1, String from, String oldId) async {
    print('zkxhckzxckjzj');

    fsploader = true;
    notifyListeners();

    print("dcdcfdc");
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, dynamic> map = HashMap();

    map["FOUZY_SPECIALS"] = fspNameCt.text.isNotEmpty ? fspNameCt.text : null;
    map["FSP_AVIL_MILK_PRICE"] =
        fspPriceCt.text.isNotEmpty ? fspPriceCt.text : null;
    map["FSP_DISCRETION"] =
        fspDescriptionCt.text.isNotEmpty ? fspDescriptionCt.text : null;
    map["FSP_AVILMILK_CATEGORY"] =
        fspCategoryCt.text.isNotEmpty ? fspCategoryCt.text : null;
    map["MAIN_CATEGORY"] =
        spmaincategorynameCt.text.isNotEmpty ? spmaincategorynameCt.text : null;
    map["MAIN_CATEGORY_ID"] = fspmainCategorySelectedId;
    map["ADDED_TIME"] = DateTime.now();
    map["COUNT"] = "";

    if (fspAvilmilkFileImg != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(fspAvilmilkFileImg!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          map["FSpAVILMILK_PHOTO"] = value;

          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      map['FSPAVILMILK_PHOTO'] = fspAvilmilkImg;
    }
    if (from == "NEW") {
      map["FSPAVIL_MILK_ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("FSPAVIL_MILK").doc(oldId).update(map);
      // ScaffoldMessenger.of().showSnackBar(SnackBar(
      //   backgroundColor: cWhite,
      //   content: Text("Updated Successfully",
      //       style: TextStyle(
      //         color: cgreen,
      //         fontSize: 15,
      //         fontWeight: FontWeight.w800,
      //       )),
      //   duration: Duration(milliseconds: 3000),
      // ));
    } else {
      print('jhsadjkasd');
      db.collection("FSPAVIL_MILK").doc(id).set(map);
      // ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
      //   backgroundColor: cWhite,
      //   content: Text("Added Successfully",
      //       style: TextStyle(
      //         color: cgreen,
      //         fontSize: 15,
      //         fontWeight: FontWeight.w800,
      //       )),
      //   duration: Duration(milliseconds: 3000),
      // ));
    }
    fsploader = false;

    getfsptypes();
    notifyListeners();
  }

  void setImages(File image) {
    fspAvilmilkFileImg = image;
    notifyListeners();
  }

  Future getImggalleryf() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setImages(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  Future getImgcamerasf() async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setImages(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  List<Fouzysp> fspavilmilklist = [];

  Future<void> getfsptypes() async {
    print("asdfghjkl");
    try {
      getavilloader = true;
      notifyListeners();

      final QuerySnapshot snapshot = await db.collection("FSPAVIL_MILK").get();

      fspavilmilklist.clear();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          print("dscdvvdf");
          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          fspavilmilklist.add(Fouzysp(
            data["FSPAVIL_MILK_ID"] as String,
            data["FOUZY_SPECIALS"] as String,
            data["FSP_AVIL_MILK_PRICE"] as String,
            data["FSP_DISCRETION"] as String,
            data["FSP_AVILMILK_CATEGORY"] as String,
            data["MAIN_CATEGORY"] as String,
            data["MAIN_CATEGORY_ID"] as String,
            data["FSpAVILMILK_PHOTO"] as String,
          ));
        }
      }
    } catch (e) {
      print("Error founding on  FSP: $e");
    } finally {
      getavilloader = false;
      notifyListeners();
    }
  }

  Future<void> deleteSpAvilmilk(String itemId, BuildContext context) async {
    try {
      fsploader = true;
      notifyListeners();

      await db.collection("FSPAVIL_MILK").doc(itemId).delete();

      fspavilmilklist.removeWhere((item) => item.id == itemId);

      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cWhite,
          content: Text(
            "Deleted Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          duration: Duration(milliseconds: 3000),
        ),
      );
    } catch (e) {
      print("Error deleting Fouzy Special Avil Milk: $e");
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cWhite,
          content: Text(
            "Error deleting item",
            style: TextStyle(
              color: myRed,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          duration: Duration(milliseconds: 3000),
        ),
      );
    } finally {
      fsploader = false;
      notifyListeners();
    }
  }

  void editFSPAvilMilk(String id, BuildContext context) {
    db.collection('FSPAVIL_MILK').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        fspNameCt.text = dataMaps["FOUZY_SPECIALS"].toString();
        fspPriceCt.text = dataMaps["FSP_AVIL_MILK_PRICE"].toString();
        fspDescriptionCt.text = dataMaps["FSP_DISCRETION"].toString();
        fspCategoryCt.text = dataMaps["FSP_AVILMILK_CATEGORY"].toString();
        spmaincategorynameCt.text = dataMaps["MAIN_CATEGORY"].toString();
        fspAvilmilkImg = dataMaps["FSpAVILMILK_PHOTO"].toString();
      }
      notifyListeners();
    });

    notifyListeners();
  }

  /// Avilmilks

  TextEditingController avilMilkNameCt = TextEditingController();
  TextEditingController avilMilkPriceCt = TextEditingController();
  TextEditingController avilMilkDescribtionCt = TextEditingController();
  TextEditingController avilMilkCategoryCt = TextEditingController();
  TextEditingController maincategorynameCt = TextEditingController();
  // TextEditingController priceCt = TextEditingController();

  String mainCategorySelectedId = '';

  bool avilloader = false;
  File? AvilmilkFileImg = null;

  String avilmilkimg = '';

  Future<void> addAvilMilkItems(
      BuildContext context1, String from, String oldId) async {
    avilloader = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, dynamic> map = HashMap();

    map["AVIL_MILK_NAME"] =
        avilMilkNameCt.text.isNotEmpty ? avilMilkNameCt.text : null;
    map["AVIL_MILK_PRICE"] =
        avilMilkPriceCt.text.isNotEmpty ? avilMilkPriceCt.text : null;
    map["DISCRETION"] = avilMilkDescribtionCt.text.isNotEmpty
        ? avilMilkDescribtionCt.text
        : null;
    map["AVILMILK_CATEGORY"] =
        avilMilkCategoryCt.text.isNotEmpty ? avilMilkCategoryCt.text : null;
    map["MAIN_CATEGORY"] =
        maincategorynameCt.text.isNotEmpty ? maincategorynameCt.text : null;
    map["MAIN_CATEGORY_ID"] =
        mainCategorySelectedId.isNotEmpty ? mainCategorySelectedId : null;
    map["ADDED_TIME"] = DateTime.now();
    map["COUNT"] = "";

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
    if (from == "NEW") {
      map["AVIL_MILK_ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("AVIL_MILK").doc(oldId).update(map);
      // ScaffoldMessenger.of().showSnackBar(SnackBar(
      //   backgroundColor: cWhite,
      //   content: Text("Updated Successfully",
      //       style: TextStyle(
      //         color: cgreen,
      //         fontSize: 15,
      //         fontWeight: FontWeight.w800,
      //       )),
      //   duration: Duration(milliseconds: 3000),
      // ));
    } else {
      db.collection("AVIL_MILK").doc(id).set(map);
      // ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
      //   backgroundColor: cWhite,
      //   content: Text("Added Successfully",
      //       style: TextStyle(
      //         color: cgreen,
      //         fontSize: 15,
      //         fontWeight: FontWeight.w800,
      //       )),
      //   duration: Duration(milliseconds: 3000),
      // ));
    }
    avilloader = false;
    avilmilkclear();
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

  // void customerclear(){
  //   customerDeskCT.clear();
  //   customerNameCT.clear();
  // }

  void avilmilkclear() {
    avilMilkNameCt.clear();
    avilMilkPriceCt.clear();
    avilMilkDescribtionCt.clear();
    avilMilkCategoryCt.clear();
    mainCategorylist.clear();
    avilmilkimg = '';
    AvilmilkFileImg = null;
    fspNameCt.clear();
    fspPriceCt.clear();
    fspDescriptionCt.clear();
    fspCategoryCt.clear();
    fspAvilmilkFileImg = null;
    fspAvilmilkImg = '';

  }

  List<AvilMilkTypes> avilmilklist = [];

  bool getavilloader = false;

  void getavilmilktypes() {
    getavilloader = true;
    notifyListeners();
    db.collection("AVIL_MILK").get().then((value) {
      if (value.docs.isNotEmpty) {
        getavilloader = false;
        notifyListeners();
        avilmilklist.clear();
        for (var element in value.docs) {
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
      notifyListeners();
    });
  }

  void deleteavilmilk(String id, BuildContext context) {
    db.collection("AVIL_MILK").doc(id).delete();
    getfsptypes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15),
          )),
    );
    notifyListeners();
  }

  void editavilmilk(String id, BuildContext context) {
    db.collection('AVIL_MILK').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        avilMilkNameCt.text = dataMaps["AVIL_MILK_NAME"].toString();
        avilMilkPriceCt.text = dataMaps["AVIL_MILK_PRICE"].toString();
        avilMilkDescribtionCt.text = dataMaps["DISCRETION"].toString();
        avilMilkCategoryCt.text = dataMaps["AVILMILK_CATEGORY"].toString();
        maincategorynameCt.text = dataMaps["MAIN_CATEGORY"].toString();
        avilmilkimg = dataMaps["AVILMILK_PHOTO"].toString();
      }
      notifyListeners();
    });

    notifyListeners();
  }

  // jucie category

  TextEditingController juciecategoryCt = TextEditingController();
  TextEditingController MainCategoryjucieyCt = TextEditingController();

  String selectedmaincategoryjucie = "";

  bool jucieloader = false;

  //Juice Categories

  void addJucieCategory(BuildContext context, String from, String oldId) {
    jucieloader = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> map = HashMap();
    map["JUICE_CATEGORY_NAME"] = juciecategoryCt.text;
    map["MAIN_CATEGORY"] = MainCategoryjucieyCt.text;
    map["MAIN_CATEGORY_ID"] = selectedmaincategoryjucie;

    if (from == "NEW") {
      map["JUICE_CATEGORY_ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("JUICE_CATEGORY").doc(oldId).update(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Updated Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      db.collection("JUICE_CATEGORY").doc(id).set(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Added Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    }
    jucieloader = false;
    getJucieCategory();
    notifyListeners();
  }

  void juciecategoryclear() {
    juciecategoryCt.clear();
  }

  List<JucieCategoryModel> juciecategorylist = [];

  bool getjuciecategoryloader = false;

  void getJucieCategory() {
    getjuciecategoryloader = true;
    notifyListeners();
    db.collection("JUICE_CATEGORY").get().then((value) {
      if (value.docs.isNotEmpty) {
        getjuciecategoryloader = false;
        notifyListeners();
        juciecategorylist.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> getjuciecategorymap = element.data();
          juciecategorylist.add(JucieCategoryModel(
            getjuciecategorymap["JUICE_CATEGORY_ID"].toString(),
            getjuciecategorymap["JUICE_CATEGORY_NAME"].toString(),
            getjuciecategorymap["MAIN_CATEGORY"].toString(),
            getjuciecategorymap["MAIN_CATEGORY_ID"].toString(),
          ));
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void deleteJucieCategory(String id, BuildContext context) {
    db.collection("JUICE_CATEGORY").doc(id).delete();
    getJucieCategory();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15),
          )),
    );
    notifyListeners();
  }

  void editJucieCategory(String id, BuildContext context) {
    db.collection('JUICE_CATEGORY').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        juciecategoryCt.text = dataMaps["JUICE_CATEGORY_NAME"].toString();
        MainCategoryjucieyCt.text = dataMaps["MAIN_CATEGORY"].toString();
      }
      notifyListeners();
    });
    getJucieCategory();

    notifyListeners();
  }

  //*  *//

  /// jucie and shakes

  TextEditingController jucieandShakesnameCt = TextEditingController();
  TextEditingController jucieandShakespriceCt = TextEditingController();

  // TextEditingController jucieandshakescategoryCt=TextEditingController();

  // String JucieCategorySelectedId='';

  bool addjucieshakesloader = false;

  void addJucieAndShakesTypes(BuildContext context, String from, String oldId,
      String jucietypesid, String jucietypesname, String maincategory) {
    addjucieshakesloader = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> map = HashMap();
    map["JUICE_SHAKES_NAME"] = jucieandShakesnameCt.text;
    map["JUICE_SHAKES_PRICE"] = jucieandShakespriceCt.text;
    map["JUICE_SHAKES_CATEGORY"] = jucietypesname;
    map["JUICE_SHAKES_CATEGORY_ID"] = jucietypesid;
    map["MAIN_CATEGORY_ID"] = maincategory;

    if (from == "NEW") {
      map["JUICE_SHAKES_ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("JUICE_SHAKES_ITEMS").doc(oldId).update(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Updated Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      db.collection("JUICE_SHAKES_ITEMS").doc(id).set(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Added Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    }
    getJuiceShakesItems(jucietypesid);
    addjucieshakesloader = false;
    notifyListeners();
  }

  List<JucieAndShakesItems> juiceshakesitemslist = [];
  List<JucieAndShakesItems> Juiceshakesalllist = [];

  bool getjuiceshakeslistloader = false;

  void getJuiceShakesItems(String juicetypeid) {
    juiceshakesitemslist.clear();
    print("dcdc");
    getjuiceshakeslistloader = true;
    notifyListeners();
    db
        .collection("JUICE_SHAKES_ITEMS")
        .where("JUICE_SHAKES_CATEGORY_ID", isEqualTo: juicetypeid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        getjuiceshakeslistloader = false;
        notifyListeners();

        for (var element in value.docs) {
          Map<dynamic, dynamic> getjucieshakeitemmap = element.data();

          juiceshakesitemslist.add(JucieAndShakesItems(
            getjucieshakeitemmap["JUICE_SHAKES_ID"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_NAME"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_PRICE"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_CATEGORY_ID"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_CATEGORY"].toString(),
            getjucieshakeitemmap["MAIN_CATEGORY_ID"].toString(),
          ));
          notifyListeners();
          print("dfvf" + element.data().toString());
        }
      }
    });
    notifyListeners();
  }

  void getJuiceShakesAllItems() {
    Juiceshakesalllist.clear();
    print("dcdc");
    getjuiceshakeslistloader = true;
    notifyListeners();
    db.collection("JUICE_SHAKES_ITEMS").get().then((value) {
      if (value.docs.isNotEmpty) {
        getjuiceshakeslistloader = false;
        notifyListeners();

        for (var element in value.docs) {
          Map<dynamic, dynamic> getjucieshakeitemmap = element.data();

          Juiceshakesalllist.add(JucieAndShakesItems(
            getjucieshakeitemmap["JUICE_SHAKES_ID"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_NAME"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_PRICE"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_CATEGORY_ID"].toString(),
            getjucieshakeitemmap["JUICE_SHAKES_CATEGORY"].toString(),
            getjucieshakeitemmap["MAIN_CATEGORY_ID"].toString(),
          ));
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void juiceshakesclear() {
    jucieandShakesnameCt.clear();
    jucieandShakespriceCt.clear();
  }

  void editjucieshake(String id, String juicetypeid, BuildContext context) {
    db.collection('JUICE_SHAKES_ITEMS').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        jucieandShakesnameCt.text = dataMaps["JUICE_SHAKES_NAME"].toString();
        jucieandShakespriceCt.text = dataMaps["JUICE_SHAKES_PRICE"].toString();
      }
      notifyListeners();
    });
    getJuiceShakesItems(juicetypeid);

    notifyListeners();
  }

  void deletejuiceshakes(String id, String juicetypeid, BuildContext context) {
    db.collection('JUICE_SHAKES_ITEMS').doc(id).delete();
    getJuiceShakesItems(juicetypeid);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15),
          )),
    );
    notifyListeners();
  }

  //*  *//

  // Ice cream

  TextEditingController addicecreamcategoryCt = TextEditingController();
  TextEditingController maincategoryIceCt = TextEditingController();

  String checkvalue = "";

  void icetypes(String? val) {
    checkvalue = val!;
    notifyListeners();
  }

  String selectedmaincategoryiceid = '';

  bool iceloader = false;

  void addIceCategory(BuildContext context, String from, String oldId) {
    iceloader = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> map = HashMap();
    map["ICE_CATEGORY_NAME"] = addicecreamcategoryCt.text;
    map["MAIN_CATEGORY_NAME"] = maincategoryIceCt.text;
    map["MAIN_CATEGORY_ID"] = selectedmaincategoryiceid;
    map["TYPE"] = checkvalue;

    if (from == "NEW") {
      map["ICE_CATEGORY_ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("ICE_CREAM_CATEGORY").doc(oldId).update(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Updated Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      db.collection("ICE_CREAM_CATEGORY").doc(id).set(map);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Added Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    }
    iceloader = false;
    getIceCreamCategoy();
    notifyListeners();
  }

  void iceCategoryclear() {
    addicecreamcategoryCt.clear();
    checkvalue = '';
  }

  List<IceCreamCategoryModel> icecategorylist = [];

  bool geticecatloader = false;

  void getIceCreamCategoy() {
    geticecatloader = true;
    notifyListeners();
    db.collection("ICE_CREAM_CATEGORY").get().then((value) {
      if (value.docs.isNotEmpty) {
        geticecatloader = false;
        notifyListeners();
        icecategorylist.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> getmap = element.data();
          icecategorylist.add(IceCreamCategoryModel(
            getmap["ICE_CATEGORY_ID"].toString(),
            getmap["ICE_CATEGORY_NAME"].toString(),
            getmap["MAIN_CATEGORY_ID"].toString(),
            getmap["MAIN_CATEGORY_NAME"].toString(),
            getmap["TYPE"].toString(),
          ));
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void deleteicecategory(String id, BuildContext context) {
    db.collection("ICE_CREAM_CATEGORY").doc(id).delete();
    getIceCreamCategoy();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15),
          )),
    );
    notifyListeners();
  }

  void editicecategory(String id, BuildContext context) {
    db.collection('ICE_CREAM_CATEGORY').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        addicecreamcategoryCt.text = dataMaps["ICE_CATEGORY_NAME"].toString();
        maincategoryIceCt.text = dataMaps["MAIN_CATEGORY_NAME"].toString();
        checkvalue = dataMaps["TYPE"].toString();
      }
      notifyListeners();
    });
    getIceCreamCategoy();
    notifyListeners();
  }

  TextEditingController icecremaflavourCT = TextEditingController();

  TextEditingController icecremaSingleCT = TextEditingController();

  TextEditingController icecremDoubleCT = TextEditingController();

  Future<void> icecreamitem(
      String icecate,
      String icecategid,
      String maincateid,
      String from,
      String oldid,
      BuildContext context) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, Object> map = HashMap();

    Map<String, Object> nestedMap = {
      'SINGLE': icecremaSingleCT.text,
      'DOUBLE': icecremDoubleCT.text,
    };

    map["ICE_FLAVOUR"] = icecremaflavourCT.text;
    // map["SINGLE_PRICE"] = icecremaSingleCT.text;
    // map["DOUBLE_PRICE"] = icecremDoubleCT.text;
    map["ICE_CATEGORY_NAME"] = icecate;
    map["ICE_CATEGORY_ID"] = icecategid;
    map["MAIN_CATEGORY_ID"] = maincateid;
    map["TYPE"] = "ICECREAM";
    map["PRODUCTS"] = nestedMap;

    if (from == "NEW") {
      map["ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("ICE_CREAM_ITEMS").doc(oldid).update(map);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Updated Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      print('hgfhjklm,');

      db.collection("ICE_CREAM_ITEMS").doc(id).set(map);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Added Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    }
    fetchIceCreamList();
  }

  void icelistclear() {
    icecremaflavourCT.clear();
    icecremaSingleCT.clear();
    icecremDoubleCT.clear();
  }

  List<IceCreamList> icecreamlist = [];
  List<ScoopsList> scoopsSized = [];

  bool geticelist = false;

  Future<void> fetchIceCreamList() async {
    // isLoading = true;
    notifyListeners();

    final querySnapshot = await db.collection("ICE_CREAM_ITEMS").get();

    if (querySnapshot.docs.isNotEmpty) {
      print('etehekhjsalkd');
      icecreamlist.clear();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        List<ScoopsList> flavours = [];
        print(data["PRODUCTS"]);
        if (data["PRODUCTS"] != null) {
          data["PRODUCTS"].forEach((key, value) {
            flavours.add(ScoopsList(key, double.parse(value), false));
          });
        }
        print('aksbdkjasd');

        icecreamlist.add(IceCreamList(
          data["ID"].toString(),
          data["ICE_FLAVOUR"].toString(),
          flavours,
        ));
        print(icecreamlist.length.toString() + 'as;lkfjaslkd');
      }
      notifyListeners();
      print(icecreamlist.length.toString() + 'as;lkfjaslkd');
    }

    print(icecreamlist.length.toString() + 'jhhknkl');
    notifyListeners();
  }

  void deleteicelist(String id, BuildContext context) {
    db.collection("ICE_CREAM_ITEMS").doc(id).delete();
    getIceCreamCategoy();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15),
          )),
    );
    fetchIceCreamList();
    notifyListeners();
  }

  void editicelist(String id, BuildContext context) {
    db.collection('ICE_CREAM_ITEMS').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        icecremaflavourCT.text = dataMaps["ICE_FLAVOUR"].toString();
        icecremaSingleCT.text = dataMaps["SINGLE_PRICE"].toString();
        icecremDoubleCT.text = dataMaps["DOUBLE_PRICE"].toString();
      }
      notifyListeners();
    });
    fetchIceCreamList();
    notifyListeners();
  }

  TextEditingController dessertsNameCT = TextEditingController();
  TextEditingController dessertspriceCT = TextEditingController();

  void dessertsItems(String icecate, String icecategid, String maincateid,
      String from, String oldid, BuildContext context) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, Object> map = HashMap();

    map["DESSERTS_NAME"] = dessertsNameCT.text;

    map["DESSERTS_PRICE"] = dessertspriceCT.text;

    map["ICE_CATEGORY_NAME"] = icecate;

    map["ICE_CATEGORY_ID"] = icecategid;

    map["MAIN_CATEGORY_ID"] = maincateid;

    map["TYPE"] = "DESSERTS";

    if (from == "NEW") {
      map["ID"] = id;
    }

    if (from == "EDIT") {
      db.collection("DESSERTS_ITEMS").doc(oldid).update(map);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Updated Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      db.collection("DESSERTS_ITEMS").doc(id).set(map);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: cWhite,
        content: Text("Added Successfully",
            style: TextStyle(
              color: cgreen,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        duration: Duration(milliseconds: 3000),
      ));
    }
    fetchDessertList();
  }

  void dessertsclear() {
    dessertsNameCT.clear();
    dessertspriceCT.clear();
  }

  List<DessertsModel> dessertslist = [];

  bool dessertsloader = false;

  void fetchDessertList() {
    dessertsloader = true;
    notifyListeners();
    db.collection("DESSERTS_ITEMS").get().then((value) {
      if (value.docs.isNotEmpty) {
        dessertsloader = false;
        notifyListeners();
        dessertslist.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> getmap = element.data();
          dessertslist.add(DessertsModel(
            getmap["ID"].toString(),
            getmap["DESSERTS_NAME"].toString(),
            getmap["DESSERTS_PRICE"].toString(),
            getmap["ICE_CATEGORY_ID"].toString(),
            getmap["ICE_CATEGORY_NAME"].toString(),
            getmap["MAIN_CATEGORY_ID"].toString(),
            getmap["TYPE"].toString(),
          ));
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void deleteDessert(String id, BuildContext context) {
    db.collection("DESSERTS_ITEMS").doc(id).delete();
    fetchDessertList();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15),
          )),
    );

    notifyListeners();
  }

  void editDessertList(String id, BuildContext context) {
    db.collection('DESSERTS_ITEMS').doc(id).get().then((value) {
      Map<dynamic, dynamic> dataMaps = value.data() as Map;
      if (value.exists) {
        dessertsNameCT.text = dataMaps["DESSERTS_NAME"].toString();
        dessertspriceCT.text = dataMaps["DESSERTS_PRICE"].toString();
      }
      notifyListeners();
    });
    fetchDessertList();
    notifyListeners();
  }

  /// CheckBox ** //

  Map<int, bool> checkboxStates = {};
  Map<int, bool> iceCreamCheckboxStates = {};
  Map<int, bool> dessertCheckboxStates = {};

  bool getCheckboxValue(
    int index1,
  ) {
    return checkboxStates[index1] ?? false;
  }

  void setCheckboxValue(int index, bool value) {
    checkboxStates[index] = value;
    notifyListeners();
  }

  /// New functions for ice cream
  bool getIceCreamCheckboxValue(int index) {
    return iceCreamCheckboxStates[index] ?? false;
  }

  void setIceCreamCheckboxValue(int index, bool value) {
    iceCreamCheckboxStates[index] = value;
    notifyListeners();
  }

  /// New functions for dessert
  bool getDessertCheckboxValue(int index) {
    return dessertCheckboxStates[index] ?? false;
  }

  void setDessertCheckboxValue(int index, bool value) {
    dessertCheckboxStates[index] = value;
    notifyListeners();
  }

  List<bool> _singleScoopSelections = [];
  List<bool> _doubleScoopSelections = [];

  void initializeIceCreamSelections() {
    _singleScoopSelections = List.generate(icecreamlist.length, (_) => false);
    _doubleScoopSelections = List.generate(icecreamlist.length, (_) => false);
    notifyListeners();
  }

  bool getIceCreamSingleScoopValue(int index) {
    if (index >= 0 && index < _singleScoopSelections.length) {
      return _singleScoopSelections[index];
    }
    return false;
  }

  bool getIceCreamDoubleScoopValue(int index) {
    if (index >= 0 && index < _doubleScoopSelections.length) {
      return _doubleScoopSelections[index];
    }
    return false;
  }

  void setIceCreamSingleScoopValue(int index, bool value) {
    if (index >= 0 && index < _singleScoopSelections.length) {
      _singleScoopSelections[index] = value;
      notifyListeners();
    }
  }

  void setIceCreamDoubleScoopValue(int index, bool value) {
    if (index >= 0 && index < _doubleScoopSelections.length) {
      _doubleScoopSelections[index] = value;
      print("double ready $index set to ${value ? 'selected' : 'unselected'}");
      notifyListeners();
    } else {
      print("no index: $index. no selections.");
    }
  }

  /// login

  TextEditingController loginCT = TextEditingController();

  /// add to cart

  Future<bool> checkItemExist(String itemid) async {
    print(itemid + ' hhhh');
    var D =
        await db.collection("CART").where("ITEMS_ID", isEqualTo: itemid).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool itemStatus = false;

  Future<void> AddCartDetails(
    String name,
    String itemsid,
    String price,
    String itemname,
    String photo,
    BuildContext context,
  ) async {
    print("kjhgfcvbn");
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, Object> map = HashMap();

    map["CART_ID"] = id;
    map["DATE_TIME"] = DateTime.now();
    map["ITEMS_NAME"] = name;
    map["ITEMS_ID"] = itemsid;
    map["ITEMS_PRICE"] = price;
    map["ITEMS_CATEGORY"] = itemname;
    map["ITEMS_PHOTO"] = photo;
    map["QTY"] = 0;
    map["TOTAL_PRICE"] = 0;


    itemStatus = await checkItemExist(itemsid);
    if (!itemStatus) {
      print("heeloooooooi");
      db.collection("CART").doc(id).set(map, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 0, 204,0),
            errorText: "Items Already To Cart",
            errorHeadline: "Oh Snap",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
      notifyListeners();
    } else {
      print("djiidi");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(days: 3000),
        backgroundColor: Colors.transparent,
        content: CustomSnackBarContent(
          colorcontainer: Colors.orange,
          errorText: "Items Already Exist",
          errorHeadline: "Warning",
          colorbubble: Colors.red,
          img: "assets/close.svg",
        ),
      ));
    }
    notifyListeners();
  }

  List<cartItemsDetails> cartitemslist = [];
  bool getcart = false;

  Future<void> getCartItems() async {
    try {
      getcart = true;
      notifyListeners();

      final QuerySnapshot snapshot = await db.collection("CART").get();

      cartitemslist.clear();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          Map<String, dynamic> cartData = doc.data() as Map<String, dynamic>;
          cartitemslist.add(cartItemsDetails(
            cartData["CART_ID"].toString(),
            DateFormat("dd-MM-yyyy hh:mm a")
                .format(cartData["DATE_TIME"].toDate()),
            cartData["ITEMS_CATEGORY"].toString(),
            cartData["ITEMS_ID"].toString(),
            cartData["ITEMS_NAME"].toString(),
            cartData["ITEMS_PHOTO"].toString(),
            cartData["ITEMS_PRICE"].toString(),
            cartData["COUNT"] != null ? cartData["COUNT"] as int : 1,
            cartData["TOTAL_PRICE"].toString(),
            cartData["QTY"].toString(),
          ));
        }
      }
    } catch (e) {
      print("Error fetching cart items: $e");
      // Handle the error appropriately
    } finally {
      getcart = false;
      notifyListeners();
    }
  }
  Future<void> delefromtecart(String id, BuildContext context) async {
    try {
      print("Deleting item with id: $id");

      // Remove the item from the local list
      int indexToRemove = cartitemslist.indexWhere((item) => item.cartid == id);
      if (indexToRemove != -1) {
        cartitemslist.removeAt(indexToRemove);
        notifyListeners(); // Update UI immediately
      } else {
        print("Item not found in local list");
      }

      // Delete from Firestore
      await db.collection("CART").doc(id).delete();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Center(
          child: Text("Deleted Successfully",
              style: TextStyle(
                color: cgreen,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              )),
        ),
        duration: Duration(milliseconds: 3000),
      ));

      // Optionally refresh the cart items
      // await getCartItems();

    } catch (e) {
      print("Error deleting item: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Error deleting item: $e"),
      ));
    }
  }

  /// icecreame Selections
  Future<void> toggleIceCreamSelection(BuildContext context, int iceCreamIndex, int scoopIndex) async {
    var iceCream = icecreamlist[iceCreamIndex];
    var scoop = iceCream.scoops[scoopIndex];

    scoop.isClicked = !scoop.isClicked;

    if (scoop.isClicked) {
      await addItemToCart(
        context: context,
        name: "${iceCream.flavourName} - ${scoop.name}",
        itemsid: "${iceCream.flavourName}_${scoop.name}",
        price: scoop.price.toString(),
        itemname: "Ice Cream",
        // photo: iceCream.photo ?? "",
      );
    } else {
      await removeItemFromCart(
        context: context,
        itemsid: "${iceCream.flavourName}_${scoop.name}",
      );
    }

    notifyListeners();
  }
  TextEditingController namecontroller=TextEditingController();
  TextEditingController desknocontroller=TextEditingController();

  void cartcustomerdetails(String id){
    Map<String, Object> map = HashMap();
    map["CUSTOMER_NAME"]=namecontroller.text;
    map["DESK_NO"]=desknocontroller.text;
    db.collection("CART").doc(id).set(map ,SetOptions(merge: true));
    notifyListeners();

  }
  void cusdetailsclear(){
    namecontroller.clear();
    desknocontroller.clear();
    dropdownval = 'Choose';
  }
  String dropdownval = 'Choose';
  var odertype = [
  "Choose",
  "Dine In",
  "Pick Up",

  ];

  void dropdown(String? newVal) {
    dropdownval = newVal!;
    notifyListeners();
  }

  /// TOTAL PRICE

  double getTotalPrice(){
    double total = 0.0;
    for(var item in cartitemslist){
      total += double.parse(item.itemprice);
    }
    return total;
  }


/// details timefromate




  Future<void> addItemToCart({
    required BuildContext context,
    required String name,
    required String itemsid,
    required String price,
    required String itemname,
    // required String photo,
  }) async {
    bool itemExists = await checkItemExist(itemsid);
    if (!itemExists) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();

      Map<String, Object> map = HashMap();
      map["CART_ID"] = id;
      map["DATE_TIME"] = DateTime.now();
      map["ITEMS_NAME"] = name;
      map["ITEMS_ID"] = itemsid;
      map["ITEMS_PRICE"] = price;
      map["ITEMS_CATEGORY"] = itemname;
      // map["ITEMS_PHOTO"] = photo;
      map["QTY"] = 1;
      map["TOTAL_PRICE"] = double.parse(price);

      await db.collection("CART").doc(id).set(map, SetOptions(merge: true));
      showSnackBar(context, "Item Added to Cart", isSuccess: true);
    } else {
      showSnackBar(context, "Item Already in Cart", isSuccess: false);
    }
  }


  Future<void> removeItemFromCart({
    required BuildContext context,
    required String itemsid,
  }) async {
    QuerySnapshot querySnapshot = await db
        .collection("CART")
        .where("ITEMS_ID", isEqualTo: itemsid)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    showSnackBar(context, "Item Removed from Cart", isSuccess: true);
  }

  Future<bool> checkItemExisticecream(String itemsid) async {
    QuerySnapshot querySnapshot = await db
        .collection("CART")
        .where("ITEMS_ID", isEqualTo: itemsid)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  void showSnackBar(BuildContext context, String message, {required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: CustomSnackBarContent(
        colorcontainer: isSuccess ? Color.fromARGB(255, 0, 204, 0) : Colors.orange,
        errorText: message,
        errorHeadline: isSuccess ? "Success" : "Warning",
        colorbubble: isSuccess ? cYellow : Colors.red,
        img: isSuccess ? "assets/check.svg" : "assets/close.svg",
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.all(5),
    ));
  }

  ///CHECKBOK

  bool flavour = false;
  void radioButtonChanges(bool bool) {
    flavour = bool;

  }

  List<cartItemsDetails> cartitemscountlist = [];

  void updateItemQuantity(String cartId, int newQuantity) {
  var index = cartitemscountlist.indexWhere((item) => item.cartid == cartId);
  if (index != -1 && newQuantity > 0) {
    cartitemscountlist[index].count = newQuantity;
  notifyListeners();
  }
  }

  // double getTotalCartPrice() {
  // return cartitemscountlist.fold(0, (total, item) => total + (item.itemprice * item.count));
  // }

  //
  // int count = 0;
  // void additems() {
  //   count++;
  //   notifyListeners();
  // }
  //
  // void minusitems() {
  //   count--;
  //   notifyListeners();
  // }

  /// datepicker

  DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  DateRangePickerController joiningDateTime = DateRangePickerController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime secondDate = DateTime.now();
  String startDateFormat = '';
  String endDateFormat = '';
  String showSelectedDate = '';
  String sortStartDate = "";
  String sortEndDate = "";
  bool isDateSelected = false;
  DateRangePickerController attedancePickerController =
      DateRangePickerController();
  DateRangePickerController attedancereport = DateRangePickerController();
  var outputDayNode1 = DateFormat('dd/MM/yyy');
  DateTime attedance = DateTime.now();
  int sundays = 0;

  void salesReport(
    BuildContext context,
  ) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: attedancePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) async {
            isDateSelected = true;

            // isDateSelected = true;
            attedancePickerController.selectedRange = val as PickerDateRange?;

            if (attedancePickerController.selectedRange!.endDate == null) {
              ///single date picker
              firstDate = attedancePickerController.selectedRange!.startDate!;
              secondDate = attedancePickerController.selectedRange!.startDate!;
              _endDate = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              final formatter = DateFormat('dd/MM/yyyy');
              showSelectedDate = formatter.format(firstDate);
              sortStartDate = formatter.format(firstDate);

              notifyListeners();
            } else {
              ///two dates select picker
              firstDate = attedancePickerController.selectedRange!.startDate!;
              secondDate = attedancePickerController.selectedRange!.endDate!;
              _endDate = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));
              print("jhbjdbvv" + _endDate.toString());
              print("Number of Sundays: $sundays");
              // getStaffData(companyid,subcompany);
              // getData(companyid,subcompany);

              // if (from == "User_attendance") {
              //   getUserAttendance(userId, firstDate2, endDate2);
              // } else {
              //   getStaffAttendance(
              //       firstDate2, endDate2, from, userId, companyid);
              // }
              isDateSelected = true;
              final formatter = DateFormat('dd/MM/yyyy');
              startDateFormat = formatter.format(firstDate);
              endDateFormat = formatter.format(secondDate);
              if (startDateFormat != endDateFormat) {
                showSelectedDate = "$startDateFormat - $endDateFormat";
              } else {
                showSelectedDate = startDateFormat;
              }

              notifyListeners();
            }
            back(context);
          },
          onCancel: () {
            isDateSelected = false;

            attedancePickerController.selectedRange = null;
            attedancePickerController.selectedDate = null;
            showSelectedDate = '';

            DateTime date = DateTime.now();
            DateTime date1 = date.subtract(Duration(
                hours: date.hour, minutes: date.minute, seconds: date.second));

            DateTime date2 = date.add(const Duration(hours: 24));
            // getStaffData(companyid,subcompany);
            // getData(companyid,subcompany);
            //
            // if (from != "graph") {
            //   getattadencelist(date1, date2, companyid,subcompany);
            // } else if (from == "projectwise") {
            //   getprojectwisereport(date1, date2, companyid);
            // } else if (from == "empprojectwise") {
            //   getempprojectreport(date1, date2, companyid, emplid);
            // } else {
            //   graphreports(date1, date2, companyid);
            // }

            // if (from == "User_attendance") {
            //   getUserAttendance(userId, date1, date2);
            // } else {
            //   getStaffAttendance(date1, date2, "All", "", companyid);
            // }
            notifyListeners();
            back(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            // title: Container(
            //     child: Text('Printers', style: TextStyle(color: my_white))),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }






  /// apploack



  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  String? appVersion;
  String currentVersion='';
  String buildNumber="";


  void lockApp() {
    print('buttonnnn');
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map[!Platform.isIOS ? 'AppVersion' : 'iOSVersion'].toString().split(',');
        if (!versions.contains(appVersion)) {
          String ADDRESS = map[!Platform.isIOS ?'ADDRESS':'ADDRESS_iOS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          print(button+'buttonnnn');
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: UpdateScreen(
              text: text,
              button: button,
              ADDRESS: ADDRESS,
            ),
          ));
        }
      }
    });
  }

  Future<void> getAppVersion() async {

    PackageInfo.fromPlatform().then((value) {
      currentVersion=value.version;
      buildNumber = value.buildNumber;
      appVersion=buildNumber;

      print(appVersion.toString()+"edfesappversion");
      print(currentVersion.toString()+"DFGVCDSQ");

      notifyListeners();
    });

  }

  void ordercount(){
    db.collection("ORDER_COUNT").doc("ORDER_COUNT").set({
      "ORDER_COUNT": FieldValue.increment(
        double.parse('1'),
      )
    }, SetOptions(merge: true));
    notifyListeners();
  }



  double orderCount=0;
  void getordercount(){
    db.collection("ORDER_COUNT").doc("ORDER_COUNT").get().then((value) {
      if(value.exists){
        Map<dynamic, dynamic> dataMap = value.data() as Map;
        orderCount= double.parse(dataMap["ORDER_COUNT"].toString());
        notifyListeners();
      }
    },);
    notifyListeners();

  }





  /// order



  // void AddOrder(String name,DateTime date,String ordertype, List itemslist, String tableno,
  //     String invoiceno,
  //     String totalprice, String slno, BuildContext context) {
  //
  //   String id = DateTime.now().millisecondsSinceEpoch.toString();
  //   Map<String, dynamic> ordermap = HashMap();
  //   ordermap["ORDER_ID"] = id;
  //   ordermap["CUSTOMER_NAME"] = name;
  //   ordermap["DATE_TIME"] = productid;
  //   ordermap["TIME"] = DateTime.now();
  //   ordermap["PRODUCT_PRICE"] = double.parse(productPRICE);
  //   ordermap["TOTAL_PRICE"] = double.parse(totalprice);
  //   ordermap["TYPE"] = choice;
  //   ordermap["PAYMENT_TYPE"] = checkvalue3;
  //   ordermap["OTHER_PRICE"] = 50;
  //   db.collection("ORDER_DETAILS").doc(id).set(ordermap);
  //
  //
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Center(
  //         child: Text("Your Order Is Confirmed",
  //             style: TextStyle(
  //                 color: twhite, fontSize: 15, fontWeight: FontWeight.bold))),
  //     backgroundColor: bmaincolor3,
  //     elevation: 10,
  //     behavior: SnackBarBehavior.floating,
  //     margin: EdgeInsets.all(5),
  //   ));
  //   notifyListeners();
  // }

}
