import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  SharedPreferences? _sharedPreferences;

  Future<void> getInstance() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  get pref => _sharedPreferences;

  static final Pref _singleton = Pref._internal();

  factory Pref() => _singleton;

  Pref._internal();
}

SharedPreferences prefs = Pref().pref;
