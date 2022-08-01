// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanButtom extends StatelessWidget {
  const ScanButtom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner_rounded),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#3D88EF', 'Cancelar', false, ScanMode.QR);
          if (barcodeScanRes != '-1') {
            final scanListProvider =
                Provider.of<ScanListProvider>(context, listen: false);
            final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

            Utils.launchURL(context, nuevoScan);
          }
        });
  }
}
