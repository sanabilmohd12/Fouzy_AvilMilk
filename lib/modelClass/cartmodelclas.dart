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

// import 'dart:io';
// import 'package:flutter/services.dart'; // For rootBundle
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:intl/intl.dart';
//
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//
// class CartItemsDetails {
//   static const String baseUrl = "https://example.com/images/"; // Replace with your actual base URL
//   static const String placeholderUrl = "assets/Sundae (1).png"; // Placeholder image path
//
//   final String cartId;
//   final DateTime dateTime;
//   final String itemCategory;
//   final String itemId;
//   final String itemName;
//   final String itemPhoto;
//   final String itemPrice;
//   String  totalPrice;
//   String qty;
//   int count; // Changed to non-`late` and initialized directly
//   File? imageFile;
//
//   CartItemsDetails(
//       this.cartId,
//       String dateTimeStr,
//       this.itemCategory,
//       this.itemId,
//       this.itemName,
//       this.itemPhoto,
//       this.itemPrice,
//       this.count, // Initialize directly
//       this.totalPrice,
//       this.qty,
//       ) : dateTime = DateFormat('dd-MM-yyyy hh:mm a').parse(dateTimeStr) {
//     // Initialize image file asynchronously
//     _initializeImageFile();
//   }
//
//   Future<void> _initializeImageFile() async {
//     if (itemPhoto.isNotEmpty) {
//       try {
//         if (Uri.parse(itemPhoto).hasScheme) {
//           // The itemPhoto is already a complete URL
//           imageFile = await DefaultCacheManager().getSingleFile(itemPhoto);
//         } else {
//           // The itemPhoto is a relative path, so we combine it with the base URL
//           String fullUrl = Uri.parse(baseUrl).resolve(itemPhoto).toString();
//           imageFile = await DefaultCacheManager().getSingleFile(fullUrl);
//         }
//       } catch (e) {
//         print("Error initializing image file from network: $e");
//         await _setPlaceholderImage();
//       }
//     } else {
//       // Use placeholder image if itemPhoto URL is empty
//       await _setPlaceholderImage();
//     }
//   }
//
//   Future<void> _setPlaceholderImage() async {
//     try {
//       final ByteData data = await rootBundle.load(placeholderUrl);
//       final buffer = data.buffer.asUint8List();
//       // Creating a temporary file from bytes
//       final tempFile = File('${Directory.systemTemp.path}/placeholder.png');
//       await tempFile.writeAsBytes(buffer);
//       imageFile = tempFile;
//     } catch (e) {
//       print("Error loading placeholder image: $e");
//       imageFile = null;
//     }
//   }
// }






