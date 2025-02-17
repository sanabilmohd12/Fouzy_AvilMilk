// import 'dart:convert';
// import 'dart:io';
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'dart:typed_data';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:provider/provider.dart';
//
// // PrinterProvider class for managing printer operations
// class PrinterProvider extends ChangeNotifier {
//   // Network printer configuration
//   String boxInPort = "9100";
//   String Ip = "192.168.1.87"; // This is your printer's IP address
//
//   // Printer status flags
//   bool printSuccess = true;
//   bool isDisposed = false;
//
//   // ESC/POS command bytes for various formatting
//   List<int> printerBytes = [0x1b, 0x61, 0x1];
//
//   // Center align
//   List<int> printerBytesLeft = [0x1b, 0x61, 0x00];   // Left align
//   List<int> printerBytesRight = [0x1b, 0x61, 0x02];  // Right align
//   List<int> printerFeed = [10];                      // Line feed
//   List<int> printerBold = [0x1b, 0x45, 0x01];        // Bold on
//   List<int> printerCancelBold = [0x1b, 0x45, 0x00];  // Bold off
//
//   // Other variables
//   String stewardName = '';
//   int tokenId = 1;
//   double kotAmount = 0.0;
//   String kotNumber = '';
//   double MGST = 0.0;
//
//   // Method to test printer connection
//   Future<bool> testPrinterConnection(String ip, int port) async {
//     try {
//       print('Testing connection to printer at $ip:$port');
//       final socket = await Socket.connect(ip, port, timeout: Duration(seconds: 5));
//       print('Successfully connected to the printer');
//       await socket.close();
//       return true;
//     } catch (e) {
//       print('Error connecting to printer: $e');
//       return false;
//     }
//   }
//
//   // Method to generate custom print commands
//   List<int> printCustom(String msg, int size, int align, int style) {
//     List<int> printdata = [];
//
//     // Define different text size commands
//     List<int> cc = [0x1B, 0x21, 0x03];  // Normal size text
//     List<int> bb = [0x1B, 0x21, 0x08];  // Bold text
//     List<int> bb2 = [0x1B, 0x21, 0x20]; // Medium bold text
//     List<int> bb3 = [0x1B, 0x21, 0x10]; // Large bold text
//     List<int> bb5 = [0x1B, 0x21, 0x02]; // Default text
//
//     // Set text size
//     switch (size) {
//       case 0: printdata += cc; break;
//       case 1: printdata += bb; break;
//       case 2: printdata += bb2; break;
//       case 3: printdata += bb3; break;
//       case 4: printdata += bb2 + bb3; break;
//       case 5: printdata += bb5; break;
//     }
//
//     // Set text alignment
//     switch (align) {
//       case 0: printdata += printerBytesLeft; break;
//       case 1: printdata += printerBytes; break;
//       case 2: printdata += printerBytesRight; break;
//     }
//
//     // Apply bold style if needed
//     if (style == 1) {
//       printdata += printerBold;
//     }
//
//     // Add the actual text content
//     printdata += utf8.encode(msg) + bb5;
//
//     // Cancel bold if it was applied
//     if (style == 1) {
//       printdata += printerCancelBold;
//     }
//
//     // Add a line feed at the end
//     printdata += printerFeed;
//
//     return printdata;
//   }
//
//   // Method to print indexed columns
//   List<int> IndexColumnPrint(String index, String str2) {
//     // Truncate strings if they're too long
//     if (str2.length > 30) str2 = str2.substring(0, 30);
//     if (index.length > 5) index = index.substring(0, 5);
//
//     List<int> SPEED = [0x1B, 0x21, 0x02];
//     List<int> printdata = SPEED;
//
//     SPEED = [0x1B, 0x44, 3, 7, 00];
//     printdata += SPEED;
//
//     printdata += printerBytesLeft;
//
//     SPEED = [0x09];
//     printdata += SPEED;
//
//     printdata += utf8.encode(index);
//     printdata += SPEED;
//     printdata += utf8.encode(str2);
//     printdata += printerFeed;
//
//     return printdata;
//   }
//
//   // Main method to print an order invoice
//   Future<void> PrintOrderInvoiceBoxIn(BuildContext context, String FloorIP) async {
//     int count = 1;
//     bool isSuccess = false;
//     const int maxRetries = 3;
//
//     try {
//       while (count <= maxRetries && !isSuccess) {
//         print("Attempting to print... Attempt #$count");
//
//         // Set up the printer
//         const PaperSize paper = PaperSize.mm80;
//         final profile = await CapabilityProfile.load();
//         final printer = NetworkPrinter(paper, profile);
//
//         // Attempt to connect to the printer
//         final PosPrintResult res = await printer.connect(FloorIP, port: int.parse(boxInPort));
//
//         print('Connection result: ${res.toString()}');
//         print('Connection message: ${res.msg}');
//
//         if (res == PosPrintResult.success) {
//           print('Successfully connected to printer');
//           isSuccess = true;
//
//           printer.text("FOUZY AVIL MILK", styles: const PosStyles(align: PosAlign.center));
//           printer.text("ELAYUR,KOOTTAVIL ROAD,PARAMMAL,KAVANUR", styles: const PosStyles(align: PosAlign.center));
//           printer.text("ELAYUR", styles: const PosStyles(align: PosAlign.center));
//           printer.emptyLines(2);
//
//           // Print receipt details
//           printer.text('Receipt No: 586965565', styles: const PosStyles(align: PosAlign.left));
//           final now = DateTime.now();
//           final formatter = DateFormat('dd/MM/yyyy hh:mm a');
//           final String timestamp = formatter.format(now);
//           printer.text('Date: $timestamp', styles: const PosStyles(align: PosAlign.left));
//           printer.text('Name: Suhail', styles: const PosStyles(align: PosAlign.left, bold: true));
//           printer.text('ID: bhfber', styles: const PosStyles(align: PosAlign.left, bold: true));
//
//           printer.hr();
//
//           // Print table header
//           printer.row([
//             PosColumn(text: 'No.', width: 1, styles: const PosStyles(align: PosAlign.left, bold: true)),
//             PosColumn(text: 'Items', width: 6, styles: const PosStyles(align: PosAlign.left, bold: true)),
//             PosColumn(text: 'Qty', width: 1, styles: const PosStyles(align: PosAlign.left, bold: true)),
//             PosColumn(text: 'Rate', width: 2, styles: const PosStyles(align: PosAlign.center, bold: true)),
//             PosColumn(text: 'Total', width: 2, styles: const PosStyles(align: PosAlign.right, bold: true)),
//           ]);
//
//           printer.hr();
//
//           // Print item details (currently using placeholder data)
//           printer.row([
//             PosColumn(text: 'eeee.productName!', width: 1, styles: const PosStyles(align: PosAlign.left)),
//             PosColumn(text: 'eeee.productName!', width: 6, styles: const PosStyles(align: PosAlign.left)),
//             PosColumn(text: 'eeee.productName!', width: 1, styles: const PosStyles(align: PosAlign.left)),
//             PosColumn(text: 'eeee.sizes != PCS', width: 2, styles: const PosStyles(align: PosAlign.left)),
//             PosColumn(text: 'eeee.quantity.toString()', width: 2, styles: const PosStyles(align: PosAlign.right)),
//           ]);
//
//           printer.feed(1);
//           printer.hr();
//
//           // Print total
//           printer.row([
//             PosColumn(text: 'Total:', width: 7, styles: const PosStyles(align: PosAlign.right, bold: true)),
//             PosColumn(text: "hbfvhvhb", width: 5, styles: const PosStyles(align: PosAlign.right, bold: true)),
//           ]);
//
//           printer.hr();
//           printer.feed(1);
//
//           // Print footer
//           printer.text('Thank you for your visit!', styles: const PosStyles(align: PosAlign.center, bold: true));
//           printer.feed(1);
//           printer.cut();
//
//           printer.disconnect();
//           print('Print job completed successfully');
//           break;
//         } else {
//           print('Failed to connect to printer. Result: ${res.toString()}, Message: ${res.msg}');
//           await Future.delayed(Duration(seconds: 2));
//         }
//
//         count++;
//       }
//
//       if (!isSuccess) {
//         print("Failed to print after $maxRetries attempts");
//         // Show an error message to the user
//       }
//     } catch (e) {
//       print('Error occurred while printing: $e');
//       // Show an error message to the user
//     }
//
//     notifyListeners();
//   }
//
//   Future<bool> isPrinterConnected(String ip, int port) async {
//     try {
//       final socket = await Socket.connect(ip, port, timeout: Duration(seconds: 5));
//       await socket.close();
//       return true;
//     } catch (e) {
//       print('Error connecting to printer: $e');
//       return false;
//     }
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String printerIp = '192.168.1.87';  // This is your printer's IP address
//   int printerPort = 9100;  // This is your printer's port
//
//   @override
//   void initState() {
//     super.initState();
//     checkPrinterConnection();
//   }
//
//   void checkPrinterConnection() async {
//     final printerProvider = Provider.of<PrinterProvider>(context, listen: false);
//     bool isConnected = await printerProvider.isPrinterConnected(printerIp, printerPort);
//     if (isConnected) {
//       // Printer is connected, proceed with printing
//       print('Printer is connected');
//       // You can update UI or proceed with printing here
//     } else {
//       // Show an error message or try to reconnect
//       print('Printer is not connected');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Printer Connection Status:',
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final printerProvider = Provider.of<PrinterProvider>(context, listen: false);
//                 printerProvider.PrintOrderInvoiceBoxIn(context, printerIp);
//               },
//               child: Text('Print Invoice'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class PrinterProvider extends ChangeNotifier {
  String boxInPort = "9100";
  String Ip = "192.168.1.87";

  bool printSuccess = true;
  bool isDisposed = false;

  List<int> printerBytes = [0x1b, 0x61, 0x1];
  List<int> printerBytesLeft = [0x1b, 0x61, 0x00];
  List<int> printerBytesRight = [0x1b, 0x61, 0x02];
  List<int> printerFeed = [10];
  List<int> printerBold = [0x1b, 0x45, 0x01];
  List<int> printerCancelBold = [0x1b, 0x45, 0x00];

  String stewardName = '';
  int tokenId = 1;
  double kotAmount = 0.0;
  String kotNumber = '';
  double MGST = 0.0;

  Future<bool> testPrinterConnection(String ip, int port) async {
    try {
      // Attempt to connect to the printer's socket
      Socket socket = await Socket.connect(ip, port, timeout: Duration(seconds: 3));
      socket.destroy(); // Close the connection
      return true;      // Connection successful
    } catch (e) {
      print("Connection error: $e");
      return false;     // Connection failed
    }
  }


  // Retry connection logic with multiple attempts
  Future<bool> attemptConnectionWithRetry(String ip, int port, int retries) async {
    for (int attempt = 1; attempt <= retries; attempt++) {
      try {
        final socket = await Socket.connect(ip, port, timeout: Duration(seconds: 5));
        await socket.close();
        print('Connection successful');
        return true;
      } catch (e) {
        print('Connection attempt $attempt failed: $e');
        await Future.delayed(Duration(seconds: 2)); // Delay between attempts
      }
    }
    print('Failed to connect to printer after $retries attempts.');
    return false;
  }

  // Custom print style function
  List<int> printCustom(String msg, int size, int align, int style) {
    List<int> printdata = [];

    List<int> cc = [0x1B, 0x21, 0x03];
    List<int> bb = [0x1B, 0x21, 0x08];
    List<int> bb2 = [0x1B, 0x21, 0x20];
    List<int> bb3 = [0x1B, 0x21, 0x10];
    List<int> bb5 = [0x1B, 0x21, 0x02];

    switch (size) {
      case 0: printdata += cc; break;
      case 1: printdata += bb; break;
      case 2: printdata += bb2; break;
      case 3: printdata += bb3; break;
      case 4: printdata += bb2 + bb3; break;
      case 5: printdata += bb5; break;
    }

    switch (align) {
      case 0: printdata += printerBytesLeft; break;
      case 1: printdata += printerBytes; break;
      case 2: printdata += printerBytesRight; break;
    }

    if (style == 1) {
      printdata += printerBold;
    }

    printdata += utf8.encode(msg) + bb5;

    if (style == 1) {
      printdata += printerCancelBold;
    }

    printdata += printerFeed;

    return printdata;
  }

  // Print invoice logic
  Future<void> printInvoice(BuildContext context, {
    required String name,
    required String deskno,
    required String ordertype,
    required String datetime,
    required List <dynamic>itemslist,
    required String invoiceNumber,
    required double totalPrice,
  }) async {
    try {
      const int maxRetries = 3;

      // Try to connect to the printer with retries
      final bool isConnected = await attemptConnectionWithRetry(Ip, int.parse(boxInPort), maxRetries);

      if (!isConnected) {
        print('Cannot connect to printer. Aborting print job.');
        return;
      }

      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();
      final printer = NetworkPrinter(paper, profile);

      final PosPrintResult res = await printer.connect(Ip, port: int.parse(boxInPort));

      if (res == PosPrintResult.success) {
        // Print the invoice header
        printer.text("FOUZY AVIL MILK", styles: const PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2));
        printer.text("ELAYUR,KOOTTAVIL ROAD,PARAMMAL,KAVANUR", styles: const PosStyles(align: PosAlign.center));
        printer.text("ELAYUR", styles: const PosStyles(align: PosAlign.center));
        printer.emptyLines(2);

        printer.text('Invoice No: $invoiceNumber', styles: const PosStyles(align: PosAlign.left));
        printer.text('Date: $datetime', styles: const PosStyles(align: PosAlign.left));
        printer.text('Name: $name', styles: const PosStyles(align: PosAlign.left, bold: true));
        printer.text('Table No: $deskno', styles: const PosStyles(align: PosAlign.left, bold: true));
        printer.text('Order Mode: $ordertype', styles: const PosStyles(align: PosAlign.left, bold: true));

        printer.hr();

        // Print the table header for the items
        printer.row([
          PosColumn(text: 'No.', width: 1, styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(text: 'Items', width: 6, styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(text: 'Qty', width: 1, styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(text: 'Rate', width: 2, styles: const PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(text: 'Total', width: 2, styles: const PosStyles(align: PosAlign.right, bold: true)),
        ]);

        printer.hr();

        // Print the item details
        for (var i = 0; i < itemslist.length; i++) {
          var item = itemslist[i];
          print('Item: ${item.itemsname}, Quantity: ${item.itemsqty}, Price: ${item.itemsprice}, Total: ${item.totalprice}');
          printer.row([
            PosColumn(text: '${i + 1}', width: 1, styles: const PosStyles(align: PosAlign.left)),
            PosColumn(text: item.itemsname, width: 6, styles: const PosStyles(align: PosAlign.left)),
            PosColumn(text: item.itemsqty.toString(), width: 1, styles: const PosStyles(align: PosAlign.left)),
            PosColumn(text: item.itemsprice.toString(), width: 2, styles: const PosStyles(align: PosAlign.left)),
            PosColumn(text: item.totalprice.toString(), width: 2, styles: const PosStyles(align: PosAlign.right)),
          ]);
        }


        printer.feed(1);
        printer.hr();

        // Print the total
        printer.row([
          PosColumn(text: 'Total:', width: 7, styles: const PosStyles(align: PosAlign.right, bold: true)),
          PosColumn(text: totalPrice.toString(), width: 5, styles: const PosStyles(align: PosAlign.right, bold: true)),
        ]);

        printer.hr();
        printer.feed(1);

        // Print the footer
        printer.text('Thank you for your visit!', styles: const PosStyles(align: PosAlign.center, bold: true));
        printer.feed(1);
        printer.cut();

        printer.disconnect();
        print('Invoice printed successfully');
      } else {
        print('Failed to connect to printer.22 Result: ${res.toString()}, Message: ${res.msg}');
      }
    } catch (e) {
      print('Error occurred while printing invoice: $e');
    }

    notifyListeners();
  }

  // Check printer connection status
  Future<bool> isPrinterConnected(String ip, int port) async {
    try {
      final socket = await Socket.connect(ip, port, timeout: Duration(seconds: 5));
      await socket.close();
      return true;
    } catch (e) {
      print('Error connecting to printer: $e');
      return false;
    }
  }
}
