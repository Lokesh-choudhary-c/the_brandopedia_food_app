import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDBHelper {
  static final CartDBHelper _instance = CartDBHelper._internal();
  factory CartDBHelper() => _instance;
  CartDBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price INTEGER,
            imagePath TEXT,
            quantity INTEGER,
            category TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE cart ADD COLUMN category TEXT');
        }
      },
    );
  }

  Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await database;
    final existing = await db.query(
      'cart',
      where: 'name = ?',
      whereArgs: [item['name']],
    );

    if (existing.isNotEmpty) {
      final updatedQuantity = (existing.first['quantity'] as int? ?? 0) + 1;
      await db.update(
        'cart',
        {'quantity': updatedQuantity},
        where: 'name = ?',
        whereArgs: [item['name']],
      );
    } else {
      await db.insert('cart', item);
    }
  }

  Future<void> updateQuantity(String name, int quantity) async {
    final db = await database;
    if (quantity == 0) {
      await db.delete('cart', where: 'name = ?', whereArgs: [name]);
    } else {
      await db.update(
        'cart',
        {'quantity': quantity},
        where: 'name = ?',
        whereArgs: [name],
      );
    }
  }

  Future<void> deleteItem(String name) async {
    final db = await database;
    await db.delete('cart', where: 'name = ?', whereArgs: [name]);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return db.query('cart');
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
