// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:currency_monitor/models/currency/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;

  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._(
      await SharedPreferences.getInstance(),
    );

    return _instance!;
  }

  final SharedPreferences _preferences;
  SharedPreferencesService._(this._preferences);

  static const _MonitoredCurrenciesKey = 'monitored-currencies-key';

  List<Currency> get monitoredCurrencies => json
      .decode(_getFromDisk(_MonitoredCurrenciesKey) ?? '[]')
      .map<Currency>((e) => Currency.fromJson(e))
      .toList();

  set monitoredCurrencies(List<Currency> value) => _saveToDisk(
      _MonitoredCurrenciesKey,
      json.encode(value.map((e) => e.toJson()).toList()));

  Future<void> clearPreferences() {
    return _preferences.clear();
  }

  void removeKey(String key) {
    _preferences.remove(key);
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void _saveToDisk(String key, dynamic content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
  }
}
