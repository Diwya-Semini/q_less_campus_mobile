import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initCartDB();
    return _database!;
  }

  static Future<Database> _initCartDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'qless_cart.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // table create for maanging the cart records
        await db.execute('''
          CREATE TABLE cart_items (
            id INTEGER PRIMARY KEY,
            item_name TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  // Add food items row or update the existing item quntity
  static Future<void> addToCart(Map<String, dynamic> item) async {
    final db = await CartDBHelper.database;

    // check the db for existing item record
    final List<Map<String, dynamic>> existing = await db.query(
      'cart_items',
      where: 'id = ?',
      whereArgs: [item['id']],
    );

    if (existing.isNotEmpty) {
      int currentQty = existing.first['quantity'] as int;
      await db.update(
        'cart_items',
        {'quantity': currentQty + 1},
        where: 'id = ?',
        whereArgs: [item['id']],
      );
    } else {
      await db.insert('cart_items', {
        'id': item['id'],
        'item_name': item['item_name'],
        'price': double.tryParse(item['price'].toString()) ?? 0.0,
        'quantity': 1,
      });
    }
  }

  // Fetch the cart items form the db
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await CartDBHelper.database;
    return await db.query('cart_items');
  }

  // Remove an item from the local db
  static Future<void> removeFromCart(int id) async {
    final db = await CartDBHelper.database;
    await db.delete('cart_items', where: 'id = ?', whereArgs: [id]);
  }

  // clear the entier table
  static Future<void> clearCart() async {
    final db = await CartDBHelper.database;
    await db.delete('cart_items');
  }
}
