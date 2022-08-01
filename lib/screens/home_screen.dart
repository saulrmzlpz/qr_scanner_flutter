import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/db_provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';
import 'package:qr_scanner/screens/addresses_screen.dart';
import 'package:qr_scanner/screens/history_screen.dart';
import 'package:qr_scanner/widgets/custom_navbar.dart';
import 'package:qr_scanner/widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () =>
                  Provider.of<ScanListProvider>(context, listen: false)
                      .borrarScans(),
              icon: const Icon(Icons.delete))
        ],
      ),
      body: const _HomeScreenBody(),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButton: const ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = Provider.of<UiProvider>(context).selectedIndex;
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    switch (selectedIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo(QrType.geo);
        return const HistoryScreen();
      case 1:
        scanListProvider.cargarScansPorTipo(QrType.http);
        return const AddressesScreen();
      default:
        return const HistoryScreen();
    }
  }
}
