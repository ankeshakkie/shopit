import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopit/model/cart_model.dart';
import 'package:shopit/repository/CartRepo.dart';
import 'package:sqflite/sqflite.dart';

class CartProvider with ChangeNotifier{

  Database? _database;
  int _counter = 0;
  int get counter => _counter;

  double _totalprice = 0.0;
  double get totalPrice => _totalprice;

  int _quantity = 1;
  int get quantity => _quantity;

  late List<CartModel> _cart;
  List<CartModel> get cart => _cart;

  Future<List<CartModel>> getAllData() async{

    _cart = await CartRepo().getData(_database);
  return _cart;

  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalprice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalprice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter(){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter(){
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrice){
    _totalprice = _totalprice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice){
    _totalprice = _totalprice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalprice;

  }

  void addQuantity(int quantity)
  {
    _quantity =  quantity++;
    notifyListeners();
  }

  void removeQuantity(int quantity)
  {
    _quantity = quantity--;
    notifyListeners();
  }

  int getQuantity()
  {
    return  _quantity;
  }





}