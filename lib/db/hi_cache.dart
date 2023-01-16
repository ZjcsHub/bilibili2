import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? _preferences;
  // 单利初始化
  static HiCache? _instance;
  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache();
    }
    return _instance!;
  }

  static Future<HiCache> preInit() async {
    if (_instance == null) {
      _instance = HiCache();
      _instance!._preferences = await SharedPreferences.getInstance();
      await ScreenUtil.ensureScreenSize();
    }
    return _instance!;
  }

  // HiCache() {
  //   SharedPreferences.getInstance().then((value) => _preferences = value);
  // }

  saveInteget(String key, int value) => _preferences?.setInt(key, value);

  saveString(String key, String value) => _preferences?.setString(key, value);

  saveBool(String key, bool value) => _preferences?.setBool(key, value);
  saveDouble(String key, double value) => _preferences?.setDouble(key, value);
  saveStringList(String key, List<String> value) =>
      _preferences?.setStringList(key, value);

  getInteger(String key, [int defaultValue = 0]) => _preferences?.getInt(key);

  getString(String key, [String defaultValue = '']) =>
      _preferences?.getString(key);
  getBool(String key, [bool defaultValue = false]) =>
      _preferences?.getBool(key);
  getDouble(String key, [double defaultValue = 0.0]) =>
      _preferences?.getDouble(key);
  getStringList(String key, [List<String> defaultValue = const <String>[]]) =>
      _preferences?.getStringList(key);
  // saveInteger(String key, int value) =>
  //     SharedPreferences.getInstance().then((sp) => sp.setInt(key, value));

  // saveString(String key, String value) =>
  //     SharedPreferences.getInstance().then((sp) => sp.setString(key, value));

  // saveBool(String key, bool value) =>
  //     SharedPreferences.getInstance().then((sp) => sp.setBool(key, value));

  // saveDouble(String key, double value) =>
  //     SharedPreferences.getInstance().then((sp) => sp.setDouble(key, value));

  // saveStringList(String key, List<String> value) =>
  //     SharedPreferences.getInstance()
  //         .then((sp) => sp.setStringList(key, value));

  // Future<int> getInteger(String key, [int defaultValue = 0]) async {
  //   var sp = await SharedPreferences.getInstance();
  //   var value = sp.getInt(key);
  //   return value ?? defaultValue;
  // }

  // Future<String> getString(String key, [String defaultValue = '']) async {
  //   var sp = await SharedPreferences.getInstance();
  //   var value = sp.getString(key);
  //   return value ?? defaultValue;
  // }

  // Future<bool> getBool(String key, [bool defaultValue = false]) async {
  //   var sp = await SharedPreferences.getInstance();
  //   var value = sp.getBool(key);
  //   return value ?? defaultValue;
  // }

  // Future<double> getDouble(String key, [double defaultValue = 0.0]) async {
  //   var sp = await SharedPreferences.getInstance();
  //   var value = sp.getDouble(key);
  //   return value ?? defaultValue;
  // }

  // Future<List<String>> getStringList(String key,
  //     [List<String> defaultValue = const <String>[]]) async {
  //   var sp = await SharedPreferences.getInstance();
  //   var value = sp.getStringList(key);
  //   return value ?? defaultValue;
  // }
}
