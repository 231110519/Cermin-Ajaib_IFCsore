import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  double _fontSize = 14.0; // ✅ nilai awal dan tipe double

  double get fontSize => _fontSize;

  void setFontSize(double newSize) {
    _fontSize = newSize;
    notifyListeners();
  }

  void resetSettings() {
    _fontSize = 14.0;
    notifyListeners();
  }
}
