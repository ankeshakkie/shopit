import 'package:shopit/constants/Constants.dart';
import 'package:shopit/database/DatabaseHandler.dart';
import 'package:shopit/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class CartRepo
{
  void createTable(Database? database) async{
    database = await DatabaseHandler().openDB();
    database?.execute('CREATE TABLE shop(id INTEGER PRIMARY KEY UNIQUE, name TEXT, initial_price INTEGER, products_price INTEGER, image TEXT, quantity INTEGER)');
  }

  Future<CartModel> insertData(Database? _db,CartModel cartModel) async {

    _db = await DatabaseHandler().openDB();
    await _db?.insert('shop', cartModel.toMap());
    return cartModel;

  }

  Future<List<CartModel>> getData(Database? db) async {
    db = await DatabaseHandler().openDB();
    final List<Map<String,dynamic?>> queryResult = await db!.query('shop');
    return queryResult.map((e) => CartModel.fromMap(e)).toList();
  }

  Future<int> delete(Database? database,int id) async{

    database = await DatabaseHandler().openDB();
    return database!.delete(
      'shop',
      where: 'id = ?',
      whereArgs: [id]
    );

  }

  Future<int> update(Database? database,CartModel cartModel) async{

    database = await DatabaseHandler().openDB();
    return database!.update(
        'shop',
        cartModel.toMap(),
        where: 'id = ?',
        whereArgs: [cartModel.id]);
  }

  

}