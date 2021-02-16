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

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, "assets/db/"+dbName);
    await deleteDatabase(path);

    // Check if the database exists
    var exists = await databaseExists(path);

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
    }
    // Open the database at a given path
    var database = await openDatabase(path);
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

    return list;
  }

}