import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/book_model.dart';

class DbProv {
  static final DbProv _instance = DbProv._internal();
  factory DbProv() => _instance;

  DbProv._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, author TEXT, rating INTEGER, isRead INTEGER)',
    );
  }

  Future<List<BkMdl>> getBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return BkMdl(
        id: maps[i]['id'],
        title: maps[i]['title'],
        author: maps[i]['author'],
        rating: maps[i]['rating'],
        isRead: maps[i]['isRead'] == 1,
      );
    });
  }

  Future<void> insertBook(BkMdl book) async {
    final db = await database;
    await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateBook(BkMdl book) async {
    final db = await database;
    await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> deleteBook(int id) async {
    final db = await database;
    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
