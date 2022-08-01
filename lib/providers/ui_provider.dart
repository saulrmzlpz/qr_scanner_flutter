// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class UiProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
