import 'dart:async';
import 'dart:collection';
import 'dart:convert';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/callFunctions.dart';
import '../modelClass/MainCategoryModelClass.dart';
import '../modelClass/avilmilktypesModelClass.dart';
import '../modelClass/cartmodelclas.dart';
import '../modelClass/fouzysp.dart';
import '../modelClass/icecreamsModelClass.dart';
import '../modelClass/jucieandshakesCateModelClass.dart';
import '../modelClass/oderModel.dart';
import '../updatescreen.dart';

extension DateTimeComparison on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class Mainprovider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Reference ref = FirebaseStorage.instance.ref("IMAGE URL");

  Mainprovider() {
    getAppVersion();
    lockApp();
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



  void countIncrement(int index, String id) {
    print("Increment called for index: $index");
    if (index >= 0 && index < cartitemslist.length) {
      cartitemslist[index].count++;
      updateItemDetails(index, id);
    }
  }

  void countDecrement(int index, String id) {
    print("Decrement called for index: $index");
    if (index >= 0 &&
        index < cartitemslist.length &&
        cartitemslist[index].count > 1) {
      cartitemslist[index].count--;
      updateItemDetails(index, id);
    }
  }

  Future<void> updateItemDetails(int index, String id) async {
    try {
      double initialPrice = double.parse(cartitemslist[index].itemPrice);
      double newPrice = initialPrice * cartitemslist[index].count;

      cartitemslist[index].totalPrice = newPrice.toStringAsFixed(2);
      cartitemslist[index].qty = cartitemslist[index].count.toString();

      print("Item: ${cartitemslist[index].itemName}");
      print("Count: ${cartitemslist[index].count}");
      print("Qty: ${cartitemslist[index].qty}");
      print("Total Price: ${cartitemslist[index].totalPrice}");

      await db.collection("CART").doc(id).set({
        "TOTAL_PRICE": cartitemslist[index].totalPrice,
        "QTY": cartitemslist[index].qty
      }, SetOptions(merge: true));

      notifyListeners();
    } catch (e) {
      print("Error updating item details: $e");
    }
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
    getloader = true;
    notifyListeners();

    db.collection("MAIN_CATEGORY").get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          print("kjhgfdxcvbn");
          mainCategorylist.clear();
          for (var element in value.docs) {
            Map<String, dynamic> getmap = element.data();
            mainCategorylist.add(MainCategory(
              getmap["MAIN_CATEGORY_ID"].toString(),
              getmap["MAIN_CATEGORY_NAME"].toString(),
            ));
            notifyListeners();
          }
        }
      },
    );
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

    } else {
      print('jhsadjkasd');
      db.collection("FSPAVIL_MILK").doc(id).set(map);
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
  List<Fouzysp> filterfspavilmilklist = [];

  Future<void> getfsptypes() async {
    try {
      print("Fetching FSPAVIL_MILK data");

      final querySnapshot = await db.collection("FSPAVIL_MILK").get();

      if (querySnapshot.docs.isNotEmpty) {
        filterfspavilmilklist.clear(); // Clear the list once before populating

        for (var doc in querySnapshot.docs) {
          print("djfhjf");

          Map<String, dynamic> data = doc.data();
          fspavilmilklist.add(Fouzysp(
            data["FSPAVIL_MILK_ID"].toString(),
            data["FOUZY_SPECIALS"].toString(),
            data["FSP_AVIL_MILK_PRICE"].toString(),
            data["FSP_DISCRETION"].toString(),
            data["FSP_AVILMILK_CATEGORY"].toString(),
            data["MAIN_CATEGORY"].toString(),
            data["MAIN_CATEGORY_ID"].toString(),
            data["FSpAVILMILK_PHOTO"].toString(),
          ));
        }
        filterfspavilmilklist = fspavilmilklist;


        notifyListeners(); // Notify listeners once after all data is processed
      } else {
        print("No documents found in FSPAVIL_MILK collection");
      }
    } catch (e) {
      print("Error fetching FSPAVIL_MILK data: $e");
      // Handle the error appropriately (e.g., show a user-friendly message)
    }
  }

  Future<void> filterfsptypes(item) async {
    filterfspavilmilklist = fspavilmilklist
        .where((a) =>
            a.name.toLowerCase().contains(item.toLowerCase()) ||
            a.price.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
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
    // notifyListeners();
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
     } else {
      db.collection("AVIL_MILK").doc(id).set(map);
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
  List<AvilMilkTypes> filteravilmilklist = [];

  bool getavilloader = false;

  Future<void> getavilmilktypes() async {
    getavilloader = true;
    // notifyListeners();
    db.collection("AVIL_MILK").get().then((value) {
      if (value.docs.isNotEmpty) {
        getavilloader = false;
        notifyListeners();
        filteravilmilklist.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> getavilmap = element.data();
          filteravilmilklist.add(AvilMilkTypes(
            getavilmap["AVIL_MILK_ID"].toString(),
            getavilmap["AVIL_MILK_NAME"].toString(),
            getavilmap["AVIL_MILK_PRICE"].toString(),
            getavilmap["DISCRETION"].toString(),
            getavilmap["AVILMILK_CATEGORY"].toString(),
            getavilmap["MAIN_CATEGORY"].toString(),
            getavilmap["MAIN_CATEGORY_ID"].toString(),
            getavilmap["AVILMILK_PHOTO"].toString(),
          ));
          filteravilmilklist = avilmilklist;
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void filterAvilmilk(item) {
    filteravilmilklist = avilmilklist
        .where((a) =>
            a.name.toLowerCase().contains(item.toLowerCase()) ||
            a.price.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
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

  Future<void> getJucieCategory() async {
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
  List<JucieAndShakesItems> filterjuiceshakesitemslist = [];
  List<JucieAndShakesItems> Juiceshakesalllist = [];

  bool getjuiceshakeslistloader = false;

  void getJuiceShakesItems(String juicetypeid) {
    juiceshakesitemslist.clear();
    print("heloooooooi");
    getjuiceshakeslistloader = true;
    // notifyListeners();
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

  bool getjucieloader = false;
  Future<void> getJuiceShakesAllItems() async {
    filterjuiceshakesitemslist.clear();
    print("dcdc");
    getjucieloader = true;
    // notifyListeners();
    db.collection("JUICE_SHAKES_ITEMS").get().then((value) {
      if (value.docs.isNotEmpty) {
        Juiceshakesalllist.clear();
        getjucieloader = false;
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
          filterjuiceshakesitemslist = Juiceshakesalllist;
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void juicesearch(item) {
    filterjuiceshakesitemslist = Juiceshakesalllist.where((a) =>
        a.name.toLowerCase().contains(item.toLowerCase()) ||
        a.price.toLowerCase().contains(item.toLowerCase())).toList();
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
  List<IceCreamCategoryModel> filterIcecategorylist = [];

  bool geticecatloader = false;

  void getIceCreamCategoy() async {
    geticecatloader = true;
    // notifyListeners();
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
    notifyListeners();

    final querySnapshot = await db.collection("ICE_CREAM_ITEMS").get();
    if (querySnapshot.docs.isNotEmpty) {
      icecreamlist.clear();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        List<ScoopsList> flavours = [];

        if (data["PRODUCTS"] != null) {
          data["PRODUCTS"].forEach((key, value) {
            // We'll load the state after creating the full list
            flavours.add(ScoopsList(key, double.parse(value), false));
          });
        }

        icecreamlist.add(IceCreamList(
          data["ID"].toString(),
          data["ICE_FLAVOUR"].toString(),
          flavours,
        ));
      }

      // Load the state after creating the full list
      await loadState();

      notifyListeners();
    }
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Deleted successfully ",
            style: TextStyle(color: cWhite, fontSize: 15))));

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
  Map<int, bool> AVILcheckboxStates = {};
  Map<int, bool> JUICEScheckboxStates = {};
  Map<int, bool> iceCreamCheckboxStates = {};
  Map<int, bool> dessertCheckboxStates = {};

  bool FSPgetCheckboxValue(
    int index1,
  ) {
    return checkboxStates[index1] ?? false;
  }

  void FSPsetCheckboxValue(int index, bool value) {
    checkboxStates[index] = value;
    notifyListeners();
  }

  bool AVILgetCheckboxValue(
    int index1,
  ) {
    return AVILcheckboxStates[index1] ?? false;
  }

  void AVILsetCheckboxValue(int index, bool value) {
    AVILcheckboxStates[index] = value;
    notifyListeners();
  }

  bool JUICESgetCheckboxValue(
    int index1,
  ) {
    return JUICEScheckboxStates[index1] ?? false;
  }

  void JUICESsetCheckboxValue(int index, bool value) {
    JUICEScheckboxStates[index] = value;
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

    // Check if the item is already in the cart
    QuerySnapshot snapshot =
        await db.collection("CART").where("ITEMS_ID", isEqualTo: itemsid).get();
    if (snapshot.docs.isNotEmpty) {
      // Item is already in the cart, remove it
      String id = snapshot.docs.first.id;
      await db.collection("CART").doc(id).delete();

      // Show a snackbar to indicate the item has been removed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 204, 0, 0),
            errorText: name + " removed from cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    } else {
      // Item is not in the cart, add it
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, Object> map = HashMap();
      map["CART_ID"] = id;
      map["DATE_TIME"] = DateTime.now();
      map["ITEMS_NAME"] = name;
      map["ITEMS_ID"] = itemsid;
      map["ITEMS_PRICE"] = price;
      map["ITEMS_CATEGORY"] = itemname;
      map["ITEMS_PHOTO"] = photo;
      map["QTY"] = 1;
      map["TOTAL_PRICE"] = price;
      // Add the item to the cart
      await db.collection("CART").doc(id).set(map, SetOptions(merge: true));

      // Show a snackbar to indicate the item has been added
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 0, 204, 0),
            errorText: name + " added to cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    }

    notifyListeners();
  }

  Future<void> AddCartDetailsAvilMilk(
    String name,
    String itemsid,
    String price,
    String itemname,
    String photo,
    BuildContext context,
  ) async {
    print("kjhgfcvbn");

    // Check if the item is already in the cart
    QuerySnapshot snapshot =
        await db.collection("CART").where("ITEMS_ID", isEqualTo: itemsid).get();
    if (snapshot.docs.isNotEmpty) {
      // Item is already in the cart, remove it
      String id = snapshot.docs.first.id;
      await db.collection("CART").doc(id).delete();

      // Show a snackbar to indicate the item has been removed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 204, 0, 0),
            errorText: name + " removed from cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    } else {
      // Item is not in the cart, add it
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, Object> map = HashMap();
      map["CART_ID"] = id;
      map["DATE_TIME"] = DateTime.now();
      map["ITEMS_NAME"] = name;
      map["ITEMS_ID"] = itemsid;
      map["ITEMS_PRICE"] = price;
      map["ITEMS_CATEGORY"] = itemname;
      map["ITEMS_PHOTO"] = photo;
      map["QTY"] = 1;
      map["TOTAL_PRICE"] = price;
      // Add the item to the cart
      await db.collection("CART").doc(id).set(map, SetOptions(merge: true));

      // Show a snackbar to indicate the item has been added
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 0, 204, 0),
            errorText: name + " added to cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    }

    notifyListeners();
  }

  Future<void> AddCartDetailsDessert(
    String name,
    String itemsid,
    String price,
    String itemname,
    BuildContext context,
  ) async {
    print("kjhgfcvbn");

    // Check if the item is already in the cart
    QuerySnapshot snapshot =
        await db.collection("CART").where("ITEMS_ID", isEqualTo: itemsid).get();
    if (snapshot.docs.isNotEmpty) {
      // Item is already in the cart, remove it
      String id = snapshot.docs.first.id;
      await db.collection("CART").doc(id).delete();

      // Show a snackbar to indicate the item has been removed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 204, 0, 0),
            errorText: name + " removed from cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    } else {
      // Item is not in the cart, add it
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, Object> map = HashMap();
      map["CART_ID"] = id;
      map["DATE_TIME"] = DateTime.now();
      map["ITEMS_NAME"] = name;
      map["ITEMS_ID"] = itemsid;
      map["ITEMS_PRICE"] = price;
      map["ITEMS_CATEGORY"] = itemname;
      map["QTY"] = 1;
      map["TOTAL_PRICE"] = price;
      // Add the item to the cart
      await db.collection("CART").doc(id).set(map, SetOptions(merge: true));

      // Show a snackbar to indicate the item has been added
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 0, 204, 0),
            errorText: name + " added to cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    }
    notifyListeners();
  }

  Future<void> AddCartDetailsJuices(
    String name,
    String itemsid,
    String price,
    String itemname,
    BuildContext context,
  ) async {
    print("kjhgfcvbn");

    // Check if the item is already in the cart
    QuerySnapshot snapshot =
        await db.collection("CART").where("ITEMS_ID", isEqualTo: itemsid).get();
    if (snapshot.docs.isNotEmpty) {
      // Item is already in the cart, remove it
      String id = snapshot.docs.first.id;
      await db.collection("CART").doc(id).delete();

      // Show a snackbar to indicate the item has been removed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 204, 0, 0),
            errorText: name + " removed from cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    } else {
      // Item is not in the cart, add it
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, Object> map = HashMap();
      map["CART_ID"] = id;
      map["DATE_TIME"] = DateTime.now();
      map["ITEMS_NAME"] = name;
      map["ITEMS_ID"] = itemsid;
      map["ITEMS_PRICE"] = price;
      map["ITEMS_CATEGORY"] = itemname;
      map["QTY"] = 1;
      map["TOTAL_PRICE"] = price;
      // Add the item to the cart
      await db.collection("CART").doc(id).set(map, SetOptions(merge: true));

      // Show a snackbar to indicate the item has been added
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: CustomSnackBarContent(
            colorcontainer: Color.fromARGB(255, 0, 204, 0),
            errorText: name + " added to cart",
            errorHeadline: "Success",
            colorbubble: cYellow,
            img: "assets/check.svg"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(5),
      ));
    }
    notifyListeners();
  }

  /// clear checkbox selection
  void ClearFSPCheckBoxs() {
    for (int i = 0; i < checkboxStates.length; i++) {
      checkboxStates[i] = false;
    }
    notifyListeners();
  }

  void ClearAVILMILKCheckBoxs() {
    for (int i = 0; i < AVILcheckboxStates.length; i++) {
      AVILcheckboxStates[i] = false;
    }
    notifyListeners();
  }

  void ClearJUICESCheckBoxs() {
    for (int i = 0; i < JUICEScheckboxStates.length; i++) {
      JUICEScheckboxStates[i] = false;
    }
    notifyListeners();
  }

  Future<void> clearAllCheckBoxes(BuildContext context) async {
    debugPrint('Before clearing: ${getCheckboxStates()}');

    // Clear other checkboxes
    clearMap(checkboxStates);
    clearMap(AVILcheckboxStates);
    clearMap(JUICEScheckboxStates);
    clearMap(dessertCheckboxStates);

    debugPrint('After clearing maps: ${getCheckboxStates()}');

    // Clear ice cream selections
    await clearIceCreamSelections();

    debugPrint('After clearing ice cream: ${getCheckboxStates()}');

    // Clear cart items
    clearCartItems();

    debugPrint('After clearing cart items: ${getCheckboxStates()}');

    // Final notification to ensure all listeners are updated
    notifyListeners();

    // Save the cleared state
    await saveState();

    debugPrint('After saving state: ${getCheckboxStates()}');
  }

  String getCheckboxStates() {
    return 'Checkbox: $checkboxStates, AVIL: $AVILcheckboxStates, JUICES: $JUICEScheckboxStates, Dessert: $dessertCheckboxStates';
  }

  void clearCartItems() {
    cartitemslist.clear(); // Assuming cartitemslist is your cart items collection
  }
  Future<void> clearIceCreamSelections() async {
    for (var iceCream in icecreamlist) {
      for (var scoop in iceCream.scoops) {
        scoop.isClicked = false;
      }
    }
    debugPrint('Ice cream selections cleared');
    notifyListeners();

    // Clear the saved state in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var iceCream in icecreamlist) {
      for (var scoop in iceCream.scoops) {
        String key = 'iceCream_${iceCream.flavourName}_${scoop.name}';
        await prefs.remove(key);
      }
    }
  }

  void clearMap(Map<int, bool> map) {
    map.clear();
    notifyListeners();
  }

  List<CartItemsDetails> cartitemslist = [];
  bool getcart = false;
  String slno = "";

  Future<void> getCartItems() async {
    print("Fetching cart items...");
    try {
      getcart = true;
      // notifyListeners();

      final QuerySnapshot snapshot = await db.collection("CART").get();

      if (snapshot.docs.isNotEmpty) {
        cartitemslist.clear();

        for (var doc in snapshot.docs) {
          Map<String, dynamic> cartData = doc.data() as Map<String, dynamic>;

          DateTime dateTime = cartData["DATE_TIME"].toDate();
          String dateString = dateTime.toString();

          cartitemslist.add(CartItemsDetails(
            cartData["CART_ID"].toString(),
            dateString,
            // DateFormat("dd-MM-yyyy hh:mm a")
            //     .format(cartData["DATE_TIME"].toDate()),
            cartData["ITEMS_CATEGORY"].toString(),
            cartData["ITEMS_ID"].toString(),
            cartData["ITEMS_NAME"].toString(),
            cartData["ITEMS_PHOTO"] ?? "",
            cartData["ITEMS_PRICE"].toString(),

            cartData["COUNT"] != null ? cartData["COUNT"] as int : 1,

            cartData["TOTAL_PRICE"].toString(),
            cartData["QTY"].toString(),
          ));
        }
        print("Cart items fetched: ${cartitemslist.length}");
      } else {
        print("No cart items found.");
      }
    } catch (e) {
      print("Error fetching cart items: $e");
    } finally {
      getcart = false;
      slno = cartitemslist.length.toString();
      notifyListeners();
    }
  }

  Future<void> delefromtecart(String id, BuildContext context) async {
    try {
      print("Deleting item with id: $id");

      // Remove the item from the local list
      int indexToRemove = cartitemslist.indexWhere((item) => item.cartId == id);
      if (indexToRemove != -1) {
        cartitemslist.removeAt(indexToRemove);
        notifyListeners(); // Update UI immediately
      } else {
        print("Item not found in local list");
      }

      // Delete from Firestore
      await db.collection("CART").doc(id).delete();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.transparent,
        content: CustomSnackBarContent(
          colorcontainer: Colors.orange,
          errorText: "Delete Succesfully",
          errorHeadline: "Oh Snap!",
          colorbubble: Colors.red,
          img: "assets/close.svg",
        ),
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

  Future<void> deleteAllFromCart(BuildContext context) async {
    try {
      // Start a batch
      WriteBatch batch = db.batch();

      // Get all documents in the CART collection
      QuerySnapshot querySnapshot = await db.collection("CART").get();

      // Add delete operations to the batch
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch
      await batch.commit();

      // Clear the local list
      cartitemslist.clear();

      // Clear all checkboxes and save the state
      await clearAllCheckBoxes(context);

      // Update UI
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.transparent,
        content: CustomSnackBarContent(
          colorcontainer: Colors.orange,
          errorText: " ",
          errorHeadline: "Cart Cleared!",
          colorbubble: Colors.red,
          img: "assets/close.svg",
        ),
      ));
    } catch (e) {
      print("Error deleting all items: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Error deleting all items: $e"),
      ));
    }
  }

  /// icecreame Selections
  Future<void> toggleIceCreamSelection(
      BuildContext context, int iceCreamIndex, int scoopIndex) async {
    try {
      final iceCream = icecreamlist[iceCreamIndex];
      final scoop = iceCream.scoops[scoopIndex];

      // Toggle the 'isClicked' state
      scoop.isClicked = !scoop.isClicked;

      if (scoop.isClicked) {
        // Add the item to the cart
        await addItemToCart(
          iceCreamIndex,
          scoopIndex,
          itemsid: "${iceCream.flavourName}_${scoop.name}",
          price: scoop.price.toString(),
          name: "${iceCream.flavourName} ${scoop.name}",
          icecreamIndex: iceCreamIndex,
          scoopindex: scoopIndex,
          itemname: '',
          context: context,
        );
      } else {
        // Remove the item from the cart
        await removeItemFromCart(
          context: context,
          itemsid: "${iceCream.flavourName}_${scoop.name}",
          name: "${iceCream.flavourName} ${scoop.name}",
        );
      }

      // Save state and notify listeners for UI updates
      await saveState();  // Ensure this saves the `isClicked` status
      notifyListeners();  // Notify UI to rebuild
    } catch (e) {
      print('Error toggling ice cream selection: $e');
    }
  }



  


  Future<void> loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var iceCream in icecreamlist) {
      for (var scoop in iceCream.scoops) {
        String key = 'iceCream_${iceCream.flavourName}_${scoop.name}';
        scoop.isClicked = prefs.getBool(key) ?? false;
      }
    }
    notifyListeners();
  }
  Future<void> saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var iceCream in icecreamlist) {
      for (var scoop in iceCream.scoops) {
        String key = 'iceCream_${iceCream.flavourName}_${scoop.name}';
        await prefs.setBool(key, scoop.isClicked);
      }
    }
    notifyListeners();
  }


  TextEditingController namecontroller = TextEditingController();
  TextEditingController desknocontroller = TextEditingController();

  void cartcustomerdetails(String id) {
    Map<String, Object> map = HashMap();
    map["CUSTOMER_NAME"] = namecontroller.text;
    map["DESK_NO"] = desknocontroller.text;
    db.collection("CART").doc(id).set(map, SetOptions(merge: true));
    notifyListeners();
  }

  void cusdetailsclear() {
    namecontroller.clear();
    desknocontroller.clear();
    dropdownval = 'Dine In';
  }

  String dropdownval = 'Dine In';
  var odertype = [
    "Dine In",
    "Parcel",
    "Home Delivery",
  ];

  void dropdown(String? newVal) {
    dropdownval = newVal!;
    notifyListeners();
  }

  /// TOTAL PRICE

  double getTotalPrice() {
    double total = 0.0;
    for (var item in cartitemslist) {
      total += double.parse(item.itemPrice);
    }
    return total;
  }

  /// details timefromate

  Future<void> addItemToCart(
    int iceCreamIndex,
    int scoopIndex, {
    required BuildContext context,
    required String name,
    required String itemsid,
    required String price,
    required String itemname,
    required int scoopindex,
    required int icecreamIndex,
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
      showSnackBar(context, name + " Added to Cart", isSuccess: true);
    } else {
      showSnackBar(context, name + " Already in Cart", isSuccess: false);
    }
  }

  Future<void> removeItemFromCart({
    required BuildContext context,
    required String itemsid,
    required String name,
  }) async {
    QuerySnapshot querySnapshot =
        await db.collection("CART").where("ITEMS_ID", isEqualTo: itemsid).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: CustomSnackBarContent(
        colorcontainer: Colors.red,
        errorText: name + " Removed Succesfully",
        errorHeadline: "Warning",
        colorbubble: cYellow,
        img: "assets/close.svg",
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.all(5),
    ));
  }

  Future<bool> checkItemExisticecream(String itemsid) async {
    QuerySnapshot querySnapshot =
        await db.collection("CART").where("ITEMS_ID", isEqualTo: itemsid).get();
    return querySnapshot.docs.isNotEmpty;
  }

  void showSnackBar(BuildContext context, String message,
      {required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: CustomSnackBarContent(
        colorcontainer:
            isSuccess ? Color.fromARGB(255, 0, 204, 0) : Colors.orange,
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

  List<CartItemsDetails> cartitemscountlist = [];

  void updateItemQuantity(String cartId, int newQuantity) {
    var index = cartitemscountlist.indexWhere((item) => item.itemId == cartId);
    if (index != -1 && newQuantity > 0) {
      cartitemscountlist[index].count = newQuantity;
      notifyListeners();
    }
  }


  /// datepicker


  DateRangePickerController dutyPickerController = DateRangePickerController();
  var outputDayNode4 = DateFormat('dd-MM-yyyy');
  DateTime regStartDate = DateTime.now();
  DateTime regFirstDate = DateTime.now();
  String dateDisplay = '';

  Future<void> dateWiseorderReport(
    BuildContext context,
  ) async {
    dateDisplay = '';
    regFirstDate = DateTime.now();
    regStartDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Restrict selection to past or current dates
    );

    if (pickedDate != null) {
      if (pickedDate.isSameDate(DateTime.now())) {
        // Reset counts and totals if today is selected
        // Clear the lists
        dateDisplay = outputDayNode4.format(regStartDate).toString();
        DateTime date1 =
            DateTime(regStartDate.year, regStartDate.month, regStartDate.day);
        DateTime date2 =
            date1.add(const Duration(hours: 23, minutes: 59, seconds: 59));
        salesreport(date1, date2);
        notifyListeners();
      } else {
        regStartDate = pickedDate;
        DateTime date1 =
            DateTime(regStartDate.year, regStartDate.month, regStartDate.day);
        DateTime date2 =
            date1.add(const Duration(hours: 23, minutes: 59, seconds: 59));
        dateDisplay = outputDayNode4.format(regStartDate).toString();
        salesreport(date1, date2);
        notifyListeners();
      }
    }

    notifyListeners();
  }

  /// apploack

  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  String? appVersion;
  String currentVersion = '';
  String buildNumber = "";

  void lockApp() {
    print('buttonnnn');
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions =
            map[!Platform.isIOS ? 'AppVersion' : 'iOSVersion']
                .toString()
                .split(',');
        if (!versions.contains(appVersion)) {
          String ADDRESS =
              map[!Platform.isIOS ? 'ADDRESS' : 'ADDRESS_iOS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          print(button + 'buttonnnn');
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
      currentVersion = value.version;
      buildNumber = value.buildNumber;
      appVersion = buildNumber;

      print(appVersion.toString() + "edfesappversion");
      print(currentVersion.toString() + "DFGVCDSQ");

      notifyListeners();
    });
  }

  void ordercount() {
    db.collection("ORDER_COUNT").doc("ORDER_COUNT").set({
      "ORDER_COUNT": FieldValue.increment(
        double.parse('1'),
      )
    }, SetOptions(merge: true));
    notifyListeners();
  }

  double orderCount = 0;
  void getordercount() {
    db.collection("ORDER_COUNT").doc("ORDER_COUNT").get().then(
      (value) {
        if (value.exists) {
          Map<dynamic, dynamic> dataMap = value.data() as Map;
          orderCount = double.parse(dataMap["ORDER_COUNT"].toString());
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }

  /// order


  List<String> cartitemidlist = [];

  void getitemsid() {
    db.collection("CART").get().then((value) {
      if (value.docs.isNotEmpty) {
        cartitemidlist.clear();
        for (var element in value.docs) {
          cartitemidlist.add(element.get("ITEMS_ID"));
          notifyListeners();
        }
        print("ddddddddddddddddddddddddd" + cartitemidlist.toString());
      }
      notifyListeners();
    });
    notifyListeners();
  }


  Future<void> addOrdersnew(
      List<CartItemsDetails> cartList,
      String customerName,
      String orderType,
      String tableNo,
      String invoiceNo,
      String totalAmt,
      BuildContext context) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, dynamic> map = {};
    Map<String, Map<String, dynamic>> productsMap = {};

    for (var element in cartList) {
      Map<String, dynamic> itemMap = {
        "Qty": element.qty,
        "Price": element.itemPrice,
        "Item Total": element.totalPrice
      };
      productsMap[element.itemName] = itemMap;
    }

    map["ORDER_ID"] = id;
    map["CUSTOMER_NAME"] = customerName;
    map["ORDER_DATE"] = DateTime.now();
    map["ORDER_TYPE"] = orderType;
    map["TABLE_NO"] = tableNo;
    map["INVOICE_NO"] = invoiceNo;
    map["PRODUCTS"] = productsMap;
    map["TOTAL_AMOUT"] = totalAmt;

    await db.collection("ORDERS").doc(id).set(map);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      content: CustomSnackBarContent(
          colorcontainer: Color.fromARGB(255, 0, 204, 0),
          errorText: "You Ordered Succesfully ",
          errorHeadline: "Oh Snap",
          colorbubble: cYellow,
          img: "assets/check.svg"),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.all(5),
    ));

    notifyListeners();
  }


  List<OrderModel> orderList = [];
  bool orderLoader = false;
  bool _disposed = false;

  Future<void> fetchOrderList() async {
    if (_disposed) return;

    orderLoader = true;
    notifyListeners();

    try {
      QuerySnapshot querySnapshot = await db.collection("ORDERS").get();

      if (_disposed) return;

      orderList.clear();
      if (querySnapshot.docs.isNotEmpty) {
        orderLoader = false;
        notifyListeners();
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> getmap = doc.data() as Map<String, dynamic>;
          orderList.add(OrderModel.fromMap(getmap));
        }
      }
    } catch (error) {
      print("Error fetching orders: $error");
    } finally {
      if (!_disposed) {}
    }
  }


  List<SalesReportOrder> salesreportlist = [];

  bool getsalsesloader = false;

  void salesreport(DateTime date1, DateTime date2) {
    getsalsesloader = true;
    notifyListeners();
    print("fvkljhbfvhjbfn");
    db
        .collection("ORDERS")
        .where("ORDER_DATE", isGreaterThanOrEqualTo: date1)
        .where("ORDER_DATE", isLessThanOrEqualTo: date2)
        .get()
        .then(
      (value) {
        print(date1.toString() + "jsjsjsjsj" + date2.toString());
        if (value.docs.isNotEmpty) {
          salesreportlist.clear();
          getsalsesloader = false;
          notifyListeners();
          for (var element in value.docs) {
            Map<dynamic, dynamic> getmap = element.data();
            salesreportlist.add(SalesReportOrder(
              getmap["ORDER_ID"].toString(),
              getmap["CUSTOMER_NAME"].toString(),
              getmap["INVOICE_NO"].toString(),
              DateFormat("dd-MM-yyyy hh:mm a")
                  .format(getmap["ORDER_DATE"].toDate())
                  .toString(),
              getmap["ORDER_TYPE"].toString(),
              getmap["TABLE_NO"].toString(),
              getmap["TOTAL_AMOUT"].toString(),
            ));
            notifyListeners();

            print("gggggg" + salesreportlist.length.toString());
          }
        }
      },
    );
    notifyListeners();
  }

  ///

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  // / call
  void makingPhoneCall(String Phone) async {
    String url = "";
    url = 'tel:$Phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  Future<void> launchWhatsApp(
      {required String phoneNumber, required String message}) async {
    final String url =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    try {
      if (!await launchUrl(Uri.parse(url))) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // Handle any errors that occur during the launch
      print('Error opening WhatsApp: $e');
    }
  }
}
