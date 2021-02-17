import 'package:desafio_queritel/utils/order_items_table.dart';
import 'package:desafio_queritel/utils/order_table.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'cart_table.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String dbName = "shopdb.db";
  String cartTable = "cart_table", orderTableName = "order_table", orderItemsTableName = "order_items_table";

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
        cartTableUpdate.setState = state;
        counter = counter + await db.update("$cartTable", cartTableUpdate.toMap(), where: 'id=?', whereArgs: [cartTableUpdate.id]);
    });

    return counter;
  }

  Future<int> addOrder(List<CartTable> cartTableList) async{
    Database db = await this.database;
    int counter = 0;

    String orderId = Uuid().toString();
    String date = DateTime.now().toString();
    double price = 0;

    cartTableList.forEach((cartTable) {
      price = price + cartTable.itemPrice;
      //return priceInit;
    });

    //add random order_id, price, date
    OrderTable orderTable = OrderTable(orderId, date, price);
    int id = await db.insert("$orderTableName", orderTable.toMap()).whenComplete(() => addOrderItems(cartTableList, orderId));
    print('INSERTADO: $id');

    List<Map> listA = await db.rawQuery('SELECT * FROM order_table');
    print('LISTA de ordenes: ${listA.length}');

    return id;
  }

  Future<int> addOrderItems(List<CartTable> cartTableList, String orderId) async{
    Database db = await this.database;

    OrderItemsTable orderItemsTable;

    int count = 0;
    cartTableList.forEach((cartTable) async{
      orderItemsTable = OrderItemsTable(
        cartTable.itemName,
        cartTable.itemCategory,
        cartTable.itemBrand,
        cartTable.weightLabel,
        orderId,
        cartTable.id,
        cartTable.itemPrice,
        cartTable.itemQuantity,
        cartTable.weight,
        cartTable.imgUrl,
      );
      count = count + await db.insert(orderItemsTableName, orderItemsTable.toMap());
    });

    List<Map> listA = await db.rawQuery('SELECT * FROM order_items_table');
    //print('LISTA de orden items con nuevo orderid: ${listA[1].values}');

    print('LISTA de orden items con nuevo orderid: ${listA.length}');

    return count;
  }

  Future<List<OrderTable>> getOrders() async {
    Database db = await this.database;
    var result =await  db.query("$orderTableName");

    var list = List<OrderTable>();

    result.forEach((element) {
      list.add(OrderTable.fromMapObject(element));
    });

    return list;
  }

  Future<List<OrderItemsTable>> getOrderItems(String orderId) async {
    Database db = await this.database;
    var result =await  db.query("$orderItemsTableName", where: "order_id = ?", whereArgs: [orderId]);

    var list = List<OrderItemsTable>();

    result.forEach((element) {
      list.add(OrderItemsTable.fromMapObject(element));
    });

    return list;
  }


}