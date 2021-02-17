import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'cart_table.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String dbName = "shopdb.db";
  String cartTable = "cart_table";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  static Future<void> init() async {

    if (_database != null) { return; }

    try {
      String _path = await getDatabasesPath() + 'example';
      _database = await openDatabase(_path);
    }
    catch(ex) {
      print(ex);
    }
  }


  Future<Database> initializeDatabase() async {
    var database;
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, "assets/db/"+dbName);

    // Check if the database exists
    var exists = await databaseExists(path);
    print('BD EXIST: $exists');
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", dbName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
      database = await openDatabase(path);
    }
    // Open the database at a given path
    //var database = await openDatabase(path);
    return database;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<List<CartTable>> getCartItems(String state) async {
    Database db = await this.database;
    var result =await  db.query("$cartTable", where: "state = ?", whereArgs: [state]);

    var list = List<CartTable>();

    result.forEach((element) {
      list.add(CartTable.fromMapObject(element));
    });

    List<Map> listA = await db.rawQuery('SELECT * FROM cart_table');
    print('LISTA ANTES: ${listA.length}');

    return list;
  }

  Future<int> activeCartItems() async { //just to active all the items in the cart, for tests.
    Database db = await this.database;
    int count = await db.rawUpdate(
        'UPDATE cart_table SET state = ?',
        ['active']);

    return count;
  }

  Future<int> updateCartItemState(List<CartTable> cartTableList, String state) async{
    Database db = await this.database;
    int counter = 0;

    cartTableList.forEach((cartTableUpdate) async{
        cartTableUpdate.state = state;
        counter = counter + await db.update("$cartTable", cartTableUpdate.toMap(), where: 'id=?', whereArgs: [cartTableUpdate.id]);
    });

    return counter;
  }

}