import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

import '../models/scan_model.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ((context, index) => Dismissible(
            background: Container(color: Colors.red),
            key: UniqueKey(),
            onDismissed: (_) =>
                scanListProvider.borrarScanPorId(scans[index].id!),
            child: ListTile(
              leading: Icon(scans[index].tipo == QrType.geo
                  ? Icons.map
                  : Icons.network_check_rounded),
              title: Text(scans[index].valor),
              subtitle: Text(scans[index].id.toString()),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => Utils.launchURL(context, scans[index]),
            ),
          )),
    );
  }
}
