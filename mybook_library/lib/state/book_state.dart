import 'package:flutter/material.dart';
import '../data/models/book_model.dart';
import '../data/db_provider.dart';
import '../data/prefs.dart';

class BkSt extends ChangeNotifier {
  List<BkMdl> _books = [];
  List<BkMdl> _filteredBooks = []; // New list for filtered books
  List<BkMdl> get books => _filteredBooks; // Return filtered books instead of all books

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
    _filteredBooks = _books; // Initialize filtered books with all books
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

  // New method to filter books based on search query
  void searchBooks(String query) {
    if (query.isEmpty) {
      _filteredBooks = _books;
    } else {
      _filteredBooks = _books.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    sortBooks();
    notifyListeners();
  }
}
