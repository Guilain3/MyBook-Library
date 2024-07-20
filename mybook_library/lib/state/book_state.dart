import 'package:flutter/material.dart';
import '../data/models/book_model.dart';
import '../data/db_provider.dart';
import '../data/prefs.dart';

class BkSt extends ChangeNotifier {
  List<BkMdl> _books = [];
  List<BkMdl> _filteredBooks = [];
  List<BkMdl> get books => _filteredBooks;

  String _sortOrder = 'title';
  String get sortOrder => _sortOrder;

  bool _showRead = true;
  bool get showRead => _showRead;

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
    _filteredBooks = _books;
    filterBooks();
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
    UsrPrefs.setSortOrder(order);
    sortBooks();
    notifyListeners();
  }

  void sortBooks() {
    switch (_sortOrder) {
      case 'author':
        _filteredBooks.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'rating':
        _filteredBooks.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'title':
      default:
        _filteredBooks.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      _filteredBooks = _books;
    } else {
      _filteredBooks = _books.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    filterBooks();
    sortBooks();
    notifyListeners();
  }

  void filterBooks() {
    if (_showRead) {
      _filteredBooks = _books;
    } else {
      _filteredBooks = _books.where((book) => !book.isRead).toList();
    }
  }

  void toggleShowRead(bool show) {
    _showRead = show;
    filterBooks();
    sortBooks();
    notifyListeners();
  }
}
