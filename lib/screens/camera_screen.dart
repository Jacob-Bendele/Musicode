import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CameraScreen {
  String _scanBarcode = "Unkown";

  String get barcode {
    return _scanBarcode;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      _scanBarcode = barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
