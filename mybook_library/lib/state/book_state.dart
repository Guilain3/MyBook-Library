import 'package:flutter/material.dart';
import '../data/models/book_model.dart';
import '../data/db_provider.dart';
import '../data/prefs.dart';

class BkSt extends ChangeNotifier {
  List<BkMdl> _books = [];
  List<BkMdl> get books => _books;

  String _sortOrder = 'title'; // Default sort order
  String get sortOrder => _sortOrder;

  BkSt() {
    loadSortOrder();
    loadBooks();
  }

  Future<void> loadSortOrder() async {
    _sortOrder = await UsrPrefs.getSortOrder();
    sortBooks();
    notifyListeners();
  }

  Future<void> loadBooks() async {
    _books = await DbProv().getBooks();
    sortBooks();
    notifyListeners();
  }

  void addBook(BkMdl book) async {
    await DbProv().insertBook(book);
    loadBooks();
  }

  void editBook(BkMdl book) async {
    await DbProv().updateBook(book);
    loadBooks();
  }

  void deleteBook(int id) async {
    await DbProv().deleteBook(id);
    loadBooks();
  }

  void setSortOrder(String order) {
    _sortOrder = order;
    sortBooks();
    notifyListeners();
  }

  void sortBooks() {
    switch (_sortOrder) {
      case 'author':
        _books.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'rating':
        _books.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'title':
      default:
        _books.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}
