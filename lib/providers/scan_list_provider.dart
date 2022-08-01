import 'package:flutter/material.dart';
import 'package:qr_scanner/providers/db_provider.dart';

class ScanListProvider with ChangeNotifier {
  List<ScanModel> scans = [];

  QrType tipoSeleccionado = QrType.http;

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DbProvider.db.nuevoScan(nuevoScan);
    //Asignar el id de la base de datos al modelo
    if (tipoSeleccionado == nuevoScan.tipo) {
      nuevoScan.id = id;
      scans.add(nuevoScan);
    }
    notifyListeners();
    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DbProvider.db.getTodosLosScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(QrType tipo) async {
    final scans = await DbProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarScans() async {
    await DbProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    final result = await DbProvider.db.deleteScan(id);
    if (result > 0) {
      scans.removeWhere((scan) => scan.id == id);
    }
  }
}
