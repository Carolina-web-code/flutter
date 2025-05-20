import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderTypeProvider with ChangeNotifier {
  bool _isPackage = false;
  static const String _spKey = 'order_type';

  bool get isPackage => _isPackage;

  Future<void> loadFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPackage = prefs.getBool(_spKey) ?? false;
    notifyListeners();
  }

  Future<void> setPackage(bool value) async {
    _isPackage = value;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_spKey, value);
  }
}