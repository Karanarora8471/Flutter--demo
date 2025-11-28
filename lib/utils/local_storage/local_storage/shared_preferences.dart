import 'package:flutter_demo/utils/utils/utils/helper/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  late SharedPreferences _prefs;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesService();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String getString(String key, {String defaultValue = ""}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }





  /* UserDataModel? getUserData(String key) {
    String ?data=_prefs.getString(key);
    if(data!=null && data.isNotEmpty)
      {
        var userData=jsonDecode(data??"");
        if(userData!=null)
        {
          return UserDataModel.fromJson(userData);
        }
      }

    return null;
  }

  Future<bool> setUserData(String key, UserDataModel userDataModel) async {
    UserDataSingleton.instance.userDataModel=userDataModel;
    return await _prefs.setString(key, jsonEncode(userDataModel.toJson()));
  }*/



  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  Future<void> clearAllExceptFirstLaunch(String authTokenKey) async {
    final firstLaunchValue = _prefs.getBool(SharedPreferenceHelper.isFirstLaunch) ?? true;
    await _prefs.clear();
    await _prefs.setBool(SharedPreferenceHelper.isFirstLaunch, firstLaunchValue);
  }


}
