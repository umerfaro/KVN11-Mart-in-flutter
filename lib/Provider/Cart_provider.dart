import 'package:flutter/material.dart';
import 'package:kvn11mart/Db/DbHelper.dart';
import 'package:kvn11mart/Models/Cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cartProvicer with ChangeNotifier {

  DB_helper db = DB_helper();

  int _cartCount = 0;
  int get cartCount => _cartCount;

  double _totalprice = 0.0;
  double get totalprice => _totalprice;

  late Future<List<Cart>> _cartList;
  Future<List<Cart>> get cartList => _cartList;

  Future<List<Cart>> getData() async{
    _cartList= db.getCartList();
    return _cartList;

  }

  void _setPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartCount', _cartCount);
    prefs.setDouble('totalprice', _totalprice);
    notifyListeners();
  }

  void _getPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartCount = prefs.getInt('cartCount') ?? 0;
    _totalprice = prefs.getDouble('totalprice') ?? 0.0;
  }

  void addCartCount() {
    _cartCount++;
    _setPrefItem();
    notifyListeners();
  }

  int getCartCount() {
    _getPrefItem();
    return _cartCount;
  }

  void removeCartCount() {
    _cartCount--;
    _setPrefItem();
    notifyListeners();
  }

  void addTotalPrice(double price) {
    _totalprice = _totalprice + price;
    _setPrefItem();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItem();
    return _totalprice;
  }

  void removeTotalPrice(double price) {
    _totalprice = _totalprice - price;
    _setPrefItem();
    notifyListeners();
  }
}
