import 'package:intl/intl.dart';

class cartItemsDetails {
  String cartid;
  String datetime;
  String itemcategory;
  String itemid;
  String itemname;
  String itemphoto;
 String itemprice;
 String totalprice;
 String qty;

  int count;
  cartItemsDetails(this.cartid, this.datetime, this.itemcategory, this.itemid,
      this.itemname, this.itemphoto, this.itemprice, this.count,this.totalprice,this.qty);
}
