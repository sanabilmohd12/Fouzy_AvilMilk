// class IceCreamCategoryModel{
//   String id;
//   String name;
//   String maincategoryid;
//   String maincategoryname;
//   String type;
//   IceCreamCategoryModel(this.id,this.name,this.maincategoryid,this.maincategoryname,this.type);
// }
//
// //
// // class IceCreamList{
// //   String id;
// //   String singleprice;
// //   String doubleprice;
// //   String icecreamcategoryid;
// //   String icecreamcategoryname;
// //   String icecreamfalovour;
// //   String maincategoryid;
// //   String type;
// //   IceCreamList(this.id,this.singleprice,this.doubleprice,this.icecreamcategoryid,this.icecreamcategoryname,this.icecreamfalovour,this.maincategoryid,this.type);
// // }
//
// class IceCreamList{
//   String id;
//   String flavourName;
//   List<ScoopsList>scoops ;
//   IceCreamList(this.id,this.flavourName,this.scoops);
//
// }
//
// class ScoopsList{
//   String name;
//   double price;
//   bool isClicked;
//   ScoopsList(this.name,this.price,this.isClicked);
// }
//
//
//
//
//  class DessertsModel{
//    String id;
//    String name;
//    String price;
//    String icecreamcategoryid;
//    String icecreamcategoryname;
//    String maincategoryid;
//    String type;
//    DessertsModel(this.id,this.name,this.price,this.icecreamcategoryid,this.icecreamcategoryname,this.maincategoryid,this.type);
//
//  }
//
//
//
//
import 'dart:convert';

class IceCreamCategoryModel {
  String id;
  String name;
  String maincategoryid;
  String maincategoryname;
  String type;

  IceCreamCategoryModel(this.id, this.name, this.maincategoryid, this.maincategoryname, this.type);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'maincategoryid': maincategoryid,
    'maincategoryname': maincategoryname,
    'type': type,
  };

  factory IceCreamCategoryModel.fromJson(Map<String, dynamic> json) => IceCreamCategoryModel(
    json['id'] as String,
    json['name'] as String,
    json['maincategoryid'] as String,
    json['maincategoryname'] as String,
    json['type'] as String,
  );
}

class IceCreamList {
  String id;
  String flavourName;
  List<ScoopsList> scoops;

  IceCreamList(this.id, this.flavourName, this.scoops);

  Map<String, dynamic> toJson() => {
    'id': id,
    'flavourName': flavourName,
    'scoops': scoops.map((scoop) => scoop.toJson()).toList(),
  };

  factory IceCreamList.fromJson(Map<String, dynamic> json) => IceCreamList(
    json['id'] as String,
    json['flavourName'] as String,
    (json['scoops'] as List<dynamic>)
        .map((e) => ScoopsList.fromJson(e as Map<String, dynamic>))
        .toList(),
  );}

class ScoopsList {
  String name;
  double price;  // Ensure this is a double, not a String
  bool isClicked;

  ScoopsList(this.name, this.price, this.isClicked);

  factory ScoopsList.fromJson(Map<String, dynamic> json) => ScoopsList(
    json['name'] as String,
    (json['price'] is String) ? double.parse(json['price']) : json['price'].toDouble(),
    json['isClicked'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'isClicked': isClicked,
  };
}
class DessertsModel {
  String id;
  String name;
  String price;
  String icecreamcategoryid;
  String icecreamcategoryname;
  String maincategoryid;
  String type;

  DessertsModel(this.id, this.name, this.price, this.icecreamcategoryid, this.icecreamcategoryname, this.maincategoryid, this.type);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'icecreamcategoryid': icecreamcategoryid,
    'icecreamcategoryname': icecreamcategoryname,
    'maincategoryid': maincategoryid,
    'type': type,
  };

  factory DessertsModel.fromJson(Map<String, dynamic> json) => DessertsModel(
    json['id'] as String,
    json['name'] as String,
    json['price'] as String,
    json['icecreamcategoryid'] as String,
    json['icecreamcategoryname'] as String,
    json['maincategoryid'] as String,
    json['type'] as String,
  );
}