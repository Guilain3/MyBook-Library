import 'package:flutter/material.dart';

class AppSt extends ChangeNotifier {
  bool _isDarkMode = false;
  String _sortOrder = 'title';

  bool get isDarkMode => _isDarkMode;
  String get sortOrder => _sortOrder;

  void setTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  void setSortOrder(String sortOrder) {
    _sortOrder = sortOrder;
    notifyListeners();
  }
}


