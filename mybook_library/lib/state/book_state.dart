import 'package:flutter/material.dart';
import '../data/models/book_model.dart';
import '../data/db_provider.dart';
import '../data/prefs.dart';

class BkSt extends ChangeNotifier {
  List<BkMdl> _books = [];
  List<BkMdl> _filteredBooks = [];
  List<BkMdl> get books => _books;
  List<BkMdl> get filteredBooks => _filteredBooks;

  String _sortOrder = 'title';
  String get sortOrder => _sortOrder;

  bool _showRead = true;
  bool get showRead => _showRead;

  String _searchQuery = '';

  BkSt() {
    loadSortOrder();
    loadBooks();
  }

  Future<void> loadSortOrder() async {
    _sortOrder = await UsrPrefs.getSortOrder();
    applyFilters();
    notifyListeners();
  }

  Future<void> loadBooks() async {
    _books = await DbProv().getBooks();
    applyFilters();
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
    applyFilters();
    notifyListeners();
  }

  void searchBooks(String query) {
    _searchQuery = query;
    applyFilters();
  }

  void toggleShowRead(bool show) {
    _showRead = show;
    applyFilters();
  }

  void resetFilters() {
    _showRead = true;
    _searchQuery = '';
    applyFilters();
  }

  void applyFilters() {
    // Filter books based on read/unread status
    List<BkMdl> tempBooks = _showRead ? _books : _books.where((book) => !book.isRead).toList();

    // Apply search query
    if (_searchQuery.isNotEmpty) {
      tempBooks = tempBooks.where((book) {
        return book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            book.author.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Sort books based on the selected sort order
    switch (_sortOrder) {
      case 'author':
        tempBooks.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'rating':
        tempBooks.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'title':
      default:
        tempBooks.sort((a, b) => a.title.compareTo(b.title));
    }

    _filteredBooks = tempBooks;
    notifyListeners();
  }
}
