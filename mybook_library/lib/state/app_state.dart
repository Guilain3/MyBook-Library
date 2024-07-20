import 'package:flutter/material.dart';
import '../data/prefs.dart';

class AppSt extends ChangeNotifier {
  bool _isDarkMode = false;
  String _sortOrder = 'title';

  bool get isDarkMode => _isDarkMode;
  String get sortOrder => _sortOrder;

  AppSt() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    _isDarkMode = await UsrPrefs.getTheme();
    _sortOrder = await UsrPrefs.getSortOrder();
    notifyListeners();
  }

  void setTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    UsrPrefs.setTheme(isDarkMode);
    notifyListeners();
  }

  void setSortOrder(String sortOrder) {
    _sortOrder = sortOrder;
    UsrPrefs.setSortOrder(sortOrder);
    notifyListeners();
  }
}
