import 'package:flutter/material.dart';
import '../Screens/add_edit_screen.dart';
import '../Screens/book_detail_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/settings_screen.dart';
import '../data/models/book_model.dart'; // Import the book model

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => HomeScreen(),
    '/add_edit': (context) {
      final BkMdl? book = ModalRoute.of(context)?.settings.arguments as BkMdl?;
      return AddEditScreen(book: book);
    },
    '/detail': (context) {
      final BkMdl? book = ModalRoute.of(context)?.settings.arguments as BkMdl?;
      return BookDetailScreen(book: book);
    },
    '/settings': (context) => SettingsScreen(),
  };
}
