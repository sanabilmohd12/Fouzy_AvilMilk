import 'dart:convert';
import 'dart:io';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:provider/provider.dart';

// PrinterProvider class for managing printer operations
class PrinterProvider extends ChangeNotifier {
  // Network printer configuration
  String boxInPort = "9100";
  String Ip = "192.168.1.37";

  // Printer status flags
  bool printSuccess = true;
  bool isDisposed = false;

  // ESC/POS command bytes for various formatting
  List<int> printerBytes = [0x1b, 0x61, 0x1];

  // Center align
  List<int> printerBytesLeft = [0x1b, 0x61, 0x00];   // Left align
  List<int> printerBytesRight = [0x1b, 0x61, 0x02];  // Right align
  List<int> printerFeed = [10];                      // Line feed
  List<int> printerBold = [0x1b, 0x45, 0x01];        // Bold on
  List<int> printerCancelBold = [0x1b, 0x45, 0x00];  // Bold off

  // Other variables (some commented out, possibly for future use)
  String stewardName = '';
  int tokenId = 1;
  double kotAmount = 0.0;
  String kotNumber = '';
  double MGST = 0.0;

  // Method to generate custom print commands
  printCustom(final String msg, final int size, final int align, final int style) {
    List<int> printdata = [];

    // Define different text size commands
    List<int> cc = [0x1B, 0x21, 0x03];  // Normal size text
    List<int> bb = [0x1B, 0x21, 0x08];  // Bold text
    List<int> bb2 = [0x1B, 0x21, 0x20]; // Medium bold text
    List<int> bb3 = [0x1B, 0x21, 0x10]; // Large bold text
    List<int> bb5 = [0x1B, 0x21, 0x02]; // Default text

    // Set text size
    switch (size) {
      case 0: printdata += cc; break;
      case 1: printdata += bb; break;
      case 2: printdata += bb2; break;
      case 3: printdata += bb3; break;
      case 4: printdata += bb2 + bb3; break;
      case 5: printdata += bb5; break;
    }

    // Set text alignment
    switch (align) {
      case 0: printdata += printerBytesLeft; break;
      case 1: printdata += printerBytes; break;
      case 2: printdata += printerBytesRight; break;
    }

    // Apply bold style if needed
    if (style == 1) {
      printdata += printerBold;
    }

    // Add the actual text content
    printdata += utf8.encode(msg) + bb5;

    // Cancel bold if it was applied
    if (style == 1) {
      printdata += printerCancelBold;
    }

    // Add a line feed at the end
    printdata += printerFeed;

    return printdata;
  }

  // Method to print indexed columns
  IndexColumnPrint(String index, String str2) {
    // Truncate strings if they're too long
    if (str2.length > 30) str2 = str2.substring(0, 30);
    if (index.length > 5) index = index.substring(0, 5);

    List<int> SPEED = [0x1B, 0x21, 0x02];
    List<int> printdata = SPEED;

    SPEED = [0x1B, 0x44, 3, 7, 00];
    printdata += SPEED;

    printdata += printerBytesLeft;

    SPEED = [0x09];
    printdata += SPEED;

    printdata += utf8.encode(index);
    printdata += SPEED;
    printdata += utf8.encode(str2);
    printdata += printerFeed;

    return printdata;
  }

  // Main method to print an order invoice
  Future<void> PrintOrderInvoiceBoxIn(BuildContext context, String floorIP) async {
    int count = 2;
    bool isSuccess = false;
    const int maxRetries = 50;

    while (count < maxRetries && !isSuccess) {
      print("Attempting to print...");
      count++;

      // Set up the printer
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();
      final printer = NetworkPrinter(paper, profile);

      // Load and resize the logo image
      ByteData data = await rootBundle.load('assets/ic_launcher.jpg');
      final Uint8List bytes = data.buffer.asUint8List();
      final img.Image logo = img.decodeImage(bytes)!;
      final img.Image resizedLogo = img.copyResize(logo, width: 300, height: 150);

      // Attempt to connect to the printer
      final PosPrintResult res = await printer.connect(floorIP, port: int.parse(boxInPort));

      if (res == PosPrintResult.success) {
        print('Successfully connected to printer');
        isSuccess = true;

        // Print the logo
        printer.image(resizedLogo);

        // Print header information
        printer.text("FOUZY AVIL MILK", styles: const PosStyles(align: PosAlign.center));
        printer.text("ELAYUR,KOOTTAVIL ROAD,PARAMMAL,KAVANUR", styles: const PosStyles(align: PosAlign.center));
        printer.text("ELAYUR", styles: const PosStyles(align: PosAlign.center));
        printer.emptyLines(2);

        // Print receipt details
        printer.text('Receipt No: 586965565', styles: const PosStyles(align: PosAlign.left));
        final now = DateTime.now();
        final formatter = DateFormat('dd/MM/yyyy hh:mm a');
        final String timestamp = formatter.format(now);
        printer.text('Date: $timestamp', styles: const PosStyles(align: PosAlign.left));
        printer.text('Name: Suhail', styles: const PosStyles(align: PosAlign.left, bold: true));
        printer.text('ID: bhfber', styles: const PosStyles(align: PosAlign.left, bold: true));

        printer.hr();

        // Print table header
        printer.row([
          PosColumn(text: 'No.', width: 1, styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(text: 'Items', width: 6, styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(text: 'Qty', width: 1, styles: const PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(text: 'Rate', width: 2, styles: const PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(text: 'Total', width: 2, styles: const PosStyles(align: PosAlign.right, bold: true)),
        ]);

        printer.hr();

        // Print item details (currently using placeholder data)
        printer.row([
          PosColumn(text: 'eeee.productName!', width: 1, styles: const PosStyles(align: PosAlign.left)),
          PosColumn(text: 'eeee.productName!', width: 6, styles: const PosStyles(align: PosAlign.left)),
          PosColumn(text: 'eeee.productName!', width: 1, styles: const PosStyles(align: PosAlign.left)),
          PosColumn(text: 'eeee.sizes != PCS', width: 2, styles: const PosStyles(align: PosAlign.left)),
          PosColumn(text: 'eeee.quantity.toString()', width: 2, styles: const PosStyles(align: PosAlign.right)),
        ]);

        printer.feed(1);
        printer.hr();

        // Print total
        printer.row([
          PosColumn(text: 'Total:', width: 7, styles: const PosStyles(align: PosAlign.right, bold: true)),
          PosColumn(text: "hbfvhvhb", width: 5, styles: const PosStyles(align: PosAlign.right, bold: true)),
        ]);

        printer.hr();
        printer.feed(1);

        // Print footer
        printer.text('Thank you for your visit!', styles: const PosStyles(align: PosAlign.center, bold: true));
        printer.feed(1);
        printer.cut();

        // Disconnect from the printer
        printer.disconnect();
        notifyListeners();
        break;
      }
    }

    if (!isSuccess) {
      // Handle the failure case if necessary
      print("Failed to print after $maxRetries attempts");
    }

    notifyListeners();
  }
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String printerIp = '192.168.1.37';  // Replace with your printer's IP
  int printerPort = 9100;  // Replace with your printer's port

  @override
  void initState() {
    super.initState();
    checkPrinterConnection();
  }

  void checkPrinterConnection() async {
    final printerProvider = Provider.of<PrinterProvider>(context, listen: false);
    bool isConnected = await printerProvider.isPrinterConnected(printerIp, printerPort);
    if (isConnected) {
      // Printer is connected, proceed with printing
      print('Printer is connected');
      // You can update UI or proceed with printing here
    } else {
      // Show an error message or try to reconnect
      print('Printer is not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Printer Connection Status:',
            ),
            ElevatedButton(
              onPressed: () {
                final printerProvider = Provider.of<PrinterProvider>(context, listen: false);
                printerProvider.PrintOrderInvoiceBoxIn(context, printerIp);
              },
              child: Text('Print Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}
