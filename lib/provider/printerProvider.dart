//
// import
// 'dart:convert';
//
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
//
//
//
// class PrinterProvider extends ChangeNotifier{
//
//   String boxInPort="9100";
//   String Ip="192.168.1.87";
//
//   // List<PrinterReGS> printerReGS = [];
//   bool printSuccess = true;
//   bool isDisposed = false;
//   // List<DriverOrderedModel> items = [];
//   // List<DriverOrderedModel> itemIn = [];
//   List<int> printerBytes = [0x1b, 0x61, 0x1];
//   List<int> printerBytesLeft = [0x1b, 0x61, 0x00];
//   List<int> printerBytesRight = [0x1b, 0x61, 0x02];
//   List<int> printerFeed = [10];
//   List<int> printerBold = [0x1b, 0x45, 0x01];
//   List<int> printerCancelBold = [0x1b, 0x45, 0x00];
//   String stewardName = '';
//   // List<OldTokenGs> oldTokens = [];
//   int tokenId = 1;
//   double kotAmount = 0.0;
//   String kotNumber = '';
//
//   double MGST = 0.0;
//   printCustom(
//       final String msg, final int size, final int align, final int style) {
//     //Print config "mode"
//
// //        new Thread(new Runnable() {
//     // @Override
//     //   public void run() {
//     List<int> printdata = [];
//
//     List<int> cc = [0x1B, 0x21, 0x03]; // 0- normal size text
//     // byte[] height = new byte[]{0x1B, 0x21, 0x11};  // 0- normal size text
//     //byte[] cc1 = new byte[]{0x1B,0x21,0x00};  // 0- normal size text
//     List<int> bb = [0x1B, 0x21, 0x08]; // 1- only bold text
//     List<int> bb2 = [0x1B, 0x21, 0x20]; // 2- bold with medium text
//     List<int> bb3 = [0x1B, 0x21, 0x10]; // 3- bold with large text
//     List<int> bb5 = [0x1B, 0x21, 0x02]; // 3- bold with default text
//     //            try {
//
//     switch (size) {
//       case 0:
//         printdata = printdata + cc;
//
//         //       outputStream.write(cc);
//
//         break;
//       case 1:
//         printdata = printdata + bb;
//         //  outputStream.write(bb);
//
//         break;
//       case 2:
//         printdata = printdata + bb2;
//
//         //    outputStream.write(bb2);
//
//         break;
//       case 3:
//         printdata = printdata + bb3;
//
//         //    outputStream.write(bb3);
//
//         break;
//       case 4:
//         printdata = printdata + bb2;
//         printdata = printdata + bb3;
//
//         //    outputStream.write(bb2);
//         //    outputStream.write(bb3);
//
//         break;
//       case 5:
//         printdata = printdata + bb5;
//
//         //    outputStream.write(bb5);
//
//         break;
//     }
//
//     switch (align) {
//       case 0:
//       //left align
//
//         printdata = printdata + printerBytesLeft;
//
//         //    outputStream.write(PrintService.ESC_ALIGN_LEFT);
//
//         break;
//       case 1:
//       //center align
//
//         printdata = printdata + printerBytes;
//
//         //    outputStream.write(PrintService.ESC_ALIGN_CENTER);
//         break;
//       case 2:
//       //right align
//         printdata = printdata + printerBytesRight;
//
//         //    outputStream.write(PrintService.ESC_ALIGN_RIGHT);
//         break;
//     }
//
//     if (style == 1) {
//       printdata = printdata + printerBold;
//     }
//
//     printdata = printdata + utf8.encode(msg) + bb5;
//     if (style == 1) {
//       printdata = printdata + printerCancelBold;
//     }
//     printdata = printdata + printerFeed;
//
//     return printdata;
//   }
//
//   IndexColumnPrint(String index, String str2) {
//     if (str2.length > 30) {
//       str2 = str2.substring(0, 30);
//     }
//     if (index.length > 5) {
//       index = index.substring(0, 5);
//     }
//
//     List<int> SPEED = [0x1B, 0x21, 0x02];
//
//     List<int> printdata = SPEED;
//
//     SPEED = [0x1B, 0x44, 3, 7, 00];
//
//     printdata = printdata + SPEED;
//
//     printdata = printdata + printerBytesLeft;
//
//     SPEED = [0x09];
//
//     printdata = printdata + SPEED;
//
//     printdata = printdata + utf8.encode(index);
//     printdata = printdata + SPEED;
//     printdata = printdata + utf8.encode(str2);
//     printdata = printdata + printerFeed;
//
//     return printdata;
//   }
//
//   Future<void> PrintOrderInvoiceBoxIn(
//
//       BuildContext context,
//       String floorIP,
//       ) async {
//     int count = 2;
//     bool isSuccess = false;
//     const int maxRetries = 50;
//
//     while (count < maxRetries && !isSuccess) {
//       print("jnmk,");
//       count++;
//       const PaperSize paper = PaperSize.mm80;
//       final profile = await CapabilityProfile.load();
//       final printer = NetworkPrinter(paper, profile);
//       ByteData data = await rootBundle.load('assets/ic_launcher.jpg');
//       final Uint8List bytes = data.buffer.asUint8List();
//       final img.Image logo = img.decodeImage(bytes)!;
//       final img.Image resizedLogo =
//       img.copyResize(logo, width: 300, height: 150);
//
//       final PosPrintResult res =
//       await printer.connect(floorIP, port: int.parse(boxInPort));
//       if (res == PosPrintResult.success) {
//         isSuccess = true;
//
//         // for (int copy = 0; copy < 2; copy++) {
//         // printer.image(resizedLogo);
//         printer.text("FOUZY AVIL MILK", styles: const PosStyles(align: PosAlign.center));
//         printer.text("ELAYUR,KOOTTAVIL ROAD,PARAMMAL,KAVANUR", styles: const PosStyles(align: PosAlign.center));
//         printer.text("ELAYUR", styles: const PosStyles(align: PosAlign.center));
//         printer.emptyLines(2);
//         printer.text('Receipt No: 586965565',
//             styles: const PosStyles(align: PosAlign.left));
//         final now = DateTime.now();
//         final formatter = DateFormat('dd/MM/yyyy hh:mm a');
//         final String timestamp = formatter.format(now);
//         // Print Date
//         printer.text('Date: $timestamp',
//             styles: const PosStyles(align: PosAlign.left));
//         printer.text('Name: Suhail',
//             styles: const PosStyles(align: PosAlign.left, bold: true));
//         printer.text('ID: bhfber',
//             styles: const PosStyles(align: PosAlign.left, bold: true));
//         printer.hr();
//         printer.row([
//           PosColumn(
//               text: 'No.',
//               width: 1,
//               styles: const PosStyles(align: PosAlign.left, bold: true)),
//           PosColumn(
//               text: 'Items',
//               width: 6,
//               styles: const PosStyles(align: PosAlign.left, bold: true)),
//           PosColumn(
//               text: 'Qty',
//               width: 1,
//               styles: const PosStyles(align: PosAlign.left, bold: true)),
//           PosColumn(
//               text: 'Rate',
//               width: 2,
//               styles: const PosStyles(align: PosAlign.center, bold: true)),
//           PosColumn(
//               text: 'Total',
//               width: 2,
//               styles: const PosStyles(align: PosAlign.right, bold: true)),
//         ]);
//         printer.hr();
//
//         int total = 0;
//         // for (var item in driverOrderedProductrList) {
//         //   for (var eeee in item.productList) {
//         printer.row([
//           PosColumn(
//               text: 'eeee.productName!',
//               width: 1,
//               styles: const PosStyles(align: PosAlign.left)),
//           PosColumn(
//               text: 'eeee.productName!',
//               width: 6,
//               styles: const PosStyles(align: PosAlign.left)),
//           PosColumn(
//               text: 'eeee.productName!',
//               width: 1,
//               styles: const PosStyles(align: PosAlign.left)),
//           PosColumn(
//               text: 'eeee.sizes != PCS',
//               // ? "${eeee.sizes}(${eeee.subProductName}pcs)"
//               // : eeee.subProductName != '1'
//               // ? "${eeee.subProductName}pcs"
//               // : "${eeee.subProductName}",
//               width: 2,
//               styles: const PosStyles(align: PosAlign.left)),
//           PosColumn(
//               text: 'eeee.quantity.toString()',
//               width: 2,
//               styles: const PosStyles(align: PosAlign.right)),
//         ]);
//
//         printer.feed(1);
//         //   }
//         // }
//         printer.hr();
//         printer.row([
//           PosColumn(
//               text: 'Total:',
//               width: 7,
//               styles: const PosStyles(align: PosAlign.right, bold: true)),
//           PosColumn(
//               text: "hbfvhvhb",
//               width: 5,
//               styles: const PosStyles(align: PosAlign.right, bold: true)),
//         ]);
//         printer.hr();
//         printer.feed(1);
//         printer.text('Thank you for your visit!',
//             styles: const PosStyles(align: PosAlign.center, bold: true));
//         printer.feed(1);
//         printer.cut();
//         // }
//
//         // Finish up
//         printer.disconnect();
//         notifyListeners();
//         break;
//       }
//     }
//
//     if (!isSuccess) {
//       // Handle the failure case if necessary
//     }
//
//     notifyListeners();
//   }
//
// }







import
'dart:convert';


import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
import 'package:esc_pos_utils/esc_pos_utils.dart';



class PrinterProvider extends ChangeNotifier{

  String boxInPort="9100";
  String Ip="192.168.1.87";

  // List<PrinterReGS> printerReGS = [];
  bool printSuccess = true;
  bool isDisposed = false;
  // List<DriverOrderedModel> items = [];
  // List<DriverOrderedModel> itemIn = [];
  List<int> printerBytes = [0x1b, 0x61, 0x1];
  List<int> printerBytesLeft = [0x1b, 0x61, 0x00];
  List<int> printerBytesRight = [0x1b, 0x61, 0x02];
  List<int> printerFeed = [10];
  List<int> printerBold = [0x1b, 0x45, 0x01];
  List<int> printerCancelBold = [0x1b, 0x45, 0x00];
  String stewardName = '';
  // List<OldTokenGs> oldTokens = [];
  int tokenId = 1;
  double kotAmount = 0.0;
  String kotNumber = '';

  double MGST = 0.0;
  printCustom(
      final String msg, final int size, final int align, final int style) {
    //Print config "mode"

//        new Thread(new Runnable() {
    // @Override
    //   public void run() {
    List<int> printdata = [];

    List<int> cc = [0x1B, 0x21, 0x03]; // 0- normal size text
    // byte[] height = new byte[]{0x1B, 0x21, 0x11};  // 0- normal size text
    //byte[] cc1 = new byte[]{0x1B,0x21,0x00};  // 0- normal size text
    List<int> bb = [0x1B, 0x21, 0x08]; // 1- only bold text
    List<int> bb2 = [0x1B, 0x21, 0x20]; // 2- bold with medium text
    List<int> bb3 = [0x1B, 0x21, 0x10]; // 3- bold with large text
    List<int> bb5 = [0x1B, 0x21, 0x02]; // 3- bold with default text
    //            try {

    switch (size) {
      case 0:
        printdata = printdata + cc;

        //       outputStream.write(cc);

        break;
      case 1:
        printdata = printdata + bb;
        //  outputStream.write(bb);

        break;
      case 2:
        printdata = printdata + bb2;

        //    outputStream.write(bb2);

        break;
      case 3:
        printdata = printdata + bb3;

        //    outputStream.write(bb3);

        break;
      case 4:
        printdata = printdata + bb2;
        printdata = printdata + bb3;

        //    outputStream.write(bb2);
        //    outputStream.write(bb3);

        break;
      case 5:
        printdata = printdata + bb5;

        //    outputStream.write(bb5);

        break;
    }

    switch (align) {
      case 0:
      //left align

        printdata = printdata + printerBytesLeft;

        //    outputStream.write(PrintService.ESC_ALIGN_LEFT);

        break;
      case 1:
      //center align

        printdata = printdata + printerBytes;

        //    outputStream.write(PrintService.ESC_ALIGN_CENTER);
        break;
      case 2:
      //right align
        printdata = printdata + printerBytesRight;

        //    outputStream.write(PrintService.ESC_ALIGN_RIGHT);
        break;
    }

    if (style == 1) {
      printdata = printdata + printerBold;
    }

    printdata = printdata + utf8.encode(msg) + bb5;
    if (style == 1) {
      printdata = printdata + printerCancelBold;
    }
    printdata = printdata + printerFeed;

    return printdata;
  }

  IndexColumnPrint(String index, String str2) {
    if (str2.length > 30) {
      str2 = str2.substring(0, 30);
    }
    if (index.length > 5) {
      index = index.substring(0, 5);
    }

    List<int> SPEED = [0x1B, 0x21, 0x02];

    List<int> printdata = SPEED;

    SPEED = [0x1B, 0x44, 3, 7, 00];

    printdata = printdata + SPEED;

    printdata = printdata + printerBytesLeft;

    SPEED = [0x09];

    printdata = printdata + SPEED;

    printdata = printdata + utf8.encode(index);
    printdata = printdata + SPEED;
    printdata = printdata + utf8.encode(str2);
    printdata = printdata + printerFeed;

    return printdata;
  }

  Future<void> PrintOrderInvoiceBoxIn(

      BuildContext context,
      String floorIP,
      ) async {
    int count = 2;
    bool isSuccess = false;
    const int maxRetries = 50;

    while (count < maxRetries && !isSuccess) {
      print("jnmk,");
      count++;
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();
      final printer = NetworkPrinter(paper, profile);
      ByteData data = await rootBundle.load('assets/ic_launcher.jpg');
      final Uint8List bytes = data.buffer.asUint8List();
      final img.Image logo = img.decodeImage(bytes)!;
      final img.Image resizedLogo =
      img.copyResize(logo, width: 300, height: 150);

      final PosPrintResult res =
      await printer.connect(floorIP, port: int.parse(boxInPort));
      if (res == PosPrintResult.success) {
        isSuccess = true;

        // for (int copy = 0; copy < 2; copy++) {
        printer.image(resizedLogo);
        printer.text("FOUZY AVIL MILK", styles: const PosStyles(align: PosAlign.center));
        printer.text("ELAYUR,KOOTTAVIL ROAD,PARAMMAL,KAVANUR", styles: const PosStyles(align: PosAlign.center));
        printer.text("ELAYUR", styles: const PosStyles(align: PosAlign.center));
        printer.emptyLines(2);
        printer.text('Receipt No: 586965565',
            styles: const PosStyles(align: PosAlign.left));
        final now = DateTime.now();
        final formatter = DateFormat('dd/MM/yyyy hh:mm a');
        final String timestamp = formatter.format(now);
        // Print Date
        printer.text('Date: $timestamp',
            styles: const PosStyles(align: PosAlign.left));
        printer.text('Name: Suhail',
            styles: const PosStyles(align: PosAlign.left, bold: true));
        printer.text('ID: bhfber',
            styles: const PosStyles(align: PosAlign.left, bold: true));
        printer.hr();
        printer.row([
          PosColumn(
              text: 'No.',
              width: 1,
              styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(
              text: 'Items',
              width: 6,
              styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(
              text: 'Qty',
              width: 1,
              styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(
              text: 'Rate',
              width: 2,
              styles: const PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(
              text: 'Total',
              width: 2,
              styles: const PosStyles(align: PosAlign.right, bold: true)),
        ]);
        printer.hr();

        int total = 0;
        // for (var item in driverOrderedProductrList) {
        //   for (var eeee in item.productList) {
        printer.row([
          PosColumn(
              text: 'eeee.productName!',
              width: 1,
              styles: const PosStyles(align: PosAlign.left)),
          PosColumn(
              text: 'eeee.productName!',
              width: 6,
              styles: const PosStyles(align: PosAlign.left)),
          PosColumn(
              text: 'eeee.productName!',
              width: 1,
              styles: const PosStyles(align: PosAlign.left)),
          PosColumn(
              text: 'eeee.sizes != PCS',
              // ? "${eeee.sizes}(${eeee.subProductName}pcs)"
              // : eeee.subProductName != '1'
              // ? "${eeee.subProductName}pcs"
              // : "${eeee.subProductName}",
              width: 2,
              styles: const PosStyles(align: PosAlign.left)),
          PosColumn(
              text: 'eeee.quantity.toString()',
              width: 2,
              styles: const PosStyles(align: PosAlign.right)),
        ]);

        printer.feed(1);
        //   }
        // }
        printer.hr();
        printer.row([
          PosColumn(
              text: 'Total:',
              width: 7,
              styles: const PosStyles(align: PosAlign.right, bold: true)),
          PosColumn(
              text: "hbfvhvhb",
              width: 5,
              styles: const PosStyles(align: PosAlign.right, bold: true)),
        ]);
        printer.hr();
        printer.feed(1);
        printer.text('Thank you for your visit!',
            styles: const PosStyles(align: PosAlign.center, bold: true));
        printer.feed(1);
        printer.cut();
        // }

        // Finish up
        printer.disconnect();
        notifyListeners();
        break;
      }
    }

    if (!isSuccess) {
      // Handle the failure case if necessary
    }

    notifyListeners();
  }

}