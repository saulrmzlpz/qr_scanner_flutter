import 'package:flutter/material.dart';
import 'package:qr_scanner/providers/db_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static void launchURL(BuildContext context, ScanModel scan) async {
    if (scan.tipo == QrType.http) {
      final url = scan.valor;
      if (await canLaunchUrlString(url)) launchUrlString(url);
    } else {
      Navigator.pushNamed(context, 'map', arguments: scan);
    }
  }
}
