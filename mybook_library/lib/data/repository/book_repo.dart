import '../db_provider.dart';
import '../models/book_model.dart';

class BkRepo {
  final DbProv dbProvider = DbProv();

  Future<List<BkMdl>> fetchBooks() async {
    return await dbProvider.getBooks();
  }

  Future<void> addBook(BkMdl book) async {
    await dbProvider.insertBook(book);
  }

  Future<void> editBook(BkMdl book) async {
    await dbProvider.updateBook(book);
  }

  Future<void> removeBook(int id) async {
    await dbProvider.deleteBook(id);
  }
}
