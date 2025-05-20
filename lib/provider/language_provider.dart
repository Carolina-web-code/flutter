import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {

  Locale? _currentLocale;

  Locale? get curentLocale => _currentLocale;

  void changeLocale(String locale) {
    _currentLocale = Locale(locale);
    notifyListeners();
  }

  Future<String> loadFromSP() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final sp = prefs.getString("language") ?? "";
    return sp;
  }

  void saveLanguageToSp() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", _currentLocale.toString());
  }
}