class IceCreamCategoryModel{
  String id;
  String name;
  String maincategoryid;
  String maincategoryname;
  String type;
  IceCreamCategoryModel(this.id,this.name,this.maincategoryid,this.maincategoryname,this.type);
}

//
// class IceCreamList{
//   String id;
//   String singleprice;
//   String doubleprice;
//   String icecreamcategoryid;
//   String icecreamcategoryname;
//   String icecreamfalovour;
//   String maincategoryid;
//   String type;
//   IceCreamList(this.id,this.singleprice,this.doubleprice,this.icecreamcategoryid,this.icecreamcategoryname,this.icecreamfalovour,this.maincategoryid,this.type);
// }

class IceCreamList{
  String id;
  String flavourName;
  List<ScoopsList>scoops ;
  IceCreamList(this.id,this.flavourName,this.scoops);
}

class ScoopsList{
  String name;
  double price;
  bool isClicked;
  ScoopsList(this.name,this.price,this.isClicked);
}




 class DessertsModel{
   String id;
   String name;
   String price;
   String icecreamcategoryid;
   String icecreamcategoryname;
   String maincategoryid;
   String type;
   DessertsModel(this.id,this.name,this.price,this.icecreamcategoryid,this.icecreamcategoryname,this.maincategoryid,this.type);

 }




