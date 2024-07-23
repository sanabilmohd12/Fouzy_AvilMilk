import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
  Future<File>? imageFuture;
  cartItemsDetails(this.cartid, this.datetime, this.itemcategory, this.itemid,
      this.itemname, this.itemphoto, this.itemprice, this.count,this.totalprice,this.qty){
    imageFuture = DefaultCacheManager().getSingleFile(itemphoto);
  }
}
