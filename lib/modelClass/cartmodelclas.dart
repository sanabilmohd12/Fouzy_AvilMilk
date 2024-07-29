import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';

class CartItemsDetails {
  static const String baseUrl = ""; // Replace with your actual base URL

  String cartId;
  String datetime;
  String itemCategory;
  String itemId;
  String itemName;
  String itemPhoto;
  String itemPrice;
  String totalPrice;
  String qty;
  int count;
  Future<File>? imageFuture;

  CartItemsDetails(
      this.cartId,
      this.datetime,
      this.itemCategory,
      this.itemId,
      this.itemName,
      this.itemPhoto,
      this.itemPrice,
      this.count,
      this.totalPrice,
      this.qty,
      ) {
    _initializeImageFuture();
  }

  void _initializeImageFuture() {
    if (itemPhoto.isNotEmpty) {
      String fullUrl;
      if (Uri.parse(itemPhoto).hasScheme) {
        // The itemPhoto is already a complete URL
        fullUrl = itemPhoto;
      } else {
        // The itemPhoto is a relative path, so we combine it with the base URL
        fullUrl = Uri.parse(baseUrl).resolve(itemPhoto).toString();
      }

      try {
        imageFuture = DefaultCacheManager().getSingleFile(fullUrl);
      } catch (e) {
        print("Error initializing image future: $e");
        // Handle the error as appropriate for your app
      }
    } else {
      print("Item photo URL is empty");
      // Handle empty URL case, maybe set a placeholder image
    }
  }
}