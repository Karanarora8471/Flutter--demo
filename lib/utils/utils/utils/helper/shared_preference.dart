import 'dart:convert';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences _prefsInstance;
  var _prefs;
  static const String isFirstLaunch = "isFirstLaunch";
  static const String _userModel = "userModel";
  static const String _FcmToken = "fcmToken";
  static const String _userId = "userId";
  static const String _userType = "userType";
  static const String _subscriptionId = "subscriptionId";
  static const String _type = "type";
  static const String _phone = "phone";
  static const String _showDialog = "showDialog";
  static const String _activeChatId = "activeChatId";
  static const String _userToken = "userToken";
  static const String _isLoggedIn = "isLoggedIn";
  static const String _createAcc = "createAcc";
  static final JsonDecoder _decoder = JsonDecoder();
  static final JsonEncoder _encoder = JsonEncoder.withIndent('  ');
  static const String _cartItemsKey = 'cart_items';
  static const String _cartItemIdsKey = 'cart_item_ids';
  static const String _kSelectedCategoryId = 'selected_category_id';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String emailId = 'emailId';
  static const String dob = 'dob';
  static const String _favIdsKey = 'fav_ids';
/*  static const String _cartItemsKey = 'cart_items';
  static const String _cartItemIdsKey = 'cart_item_ids';
  static const String _kSelectedCategoryId = 'selected_category_id';*/


  static final SharedPreferenceHelper _singleton =
      SharedPreferenceHelper._internal();

  SharedPreferenceHelper._internal() {
    _prefs ??= SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  factory SharedPreferenceHelper() {
    return _singleton;
  }

  static Set<int> _readFavsSync() {
    final list = _prefsInstance.getStringList(_favIdsKey) ?? const <String>[];
    return list.map(int.parse).toSet();
  }

  static Future<Set<int>> getFavorites() async {

    return _readFavsSync();
  }

  static Future<void> _writeFavs(Set<int> favs) async {
    await _prefsInstance.setStringList(
      _favIdsKey,
      favs.map((e) => e.toString()).toList(),
    );
  }

  static Future<bool> isFavorite(int id) async {
    final favs = _readFavsSync();
    return favs.contains(id);
  }

  static Future<void> addFavorite(int id) async {
    final favs = _readFavsSync()..add(id);
    await _writeFavs(favs);
  }

  static Future<void> removeFavorite(int id) async {
    final favs = _readFavsSync()..remove(id);
    await _writeFavs(favs);
  }

  static Future<void> toggleFavorite(int id) async {
    final favs = _readFavsSync();
    favs.contains(id) ? favs.remove(id) : favs.add(id);
    await _writeFavs(favs);
  }




  static Future<void> saveSelectedCategoryId(int id) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_kSelectedCategoryId, id);
  }

  /// Read (null if not set)
  static Future<int?> getSelectedCategoryId() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(_kSelectedCategoryId);
  }

  Future<String?> getSavedDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }


  /// Clear
  static Future<void> clearSelectedCategoryId() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kSelectedCategoryId);
  }

  Future<void> saveCart({
    required Map<int, int> cartItems,
    required Map<int, int> cartItemIds,
  }) async {
    final prefs = _prefsInstance;

    final cartMap = cartItems.map((k, v) => MapEntry(k.toString(), v));
    final idMap = cartItemIds.map((k, v) => MapEntry(k.toString(), v));

    await prefs.setString(_cartItemsKey, jsonEncode(cartMap));
    await prefs.setString(_cartItemIdsKey, jsonEncode(idMap));
  }

  Future<({Map<int, int> items, Map<int, int> ids})> loadCart() async {
    final prefs = _prefsInstance;

    final cartJson = prefs.getString(_cartItemsKey);
    final idJson = prefs.getString(_cartItemIdsKey);

    final items = <int, int>{};
    final ids = <int, int>{};

    if (cartJson != null) {
      final decoded = jsonDecode(cartJson) as Map<String, dynamic>;
      decoded.forEach((k, v) => items[int.parse(k)] = (v as num).toInt());
    }

    if (idJson != null) {
      final decoded = jsonDecode(idJson) as Map<String, dynamic>;
      decoded.forEach((k, v) => ids[int.parse(k)] = (v as num).toInt());
    }

    return (items: items, ids: ids);
  }



  Future<void> clearCart() async {
    final prefs = _prefsInstance;
    await prefs.remove(_cartItemsKey);
    await prefs.remove(_cartItemIdsKey);
  }

  _savePref(String key, Object? value) async {
    var prefs = _prefsInstance;
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
    if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is Double || value is Float) {
      return prefs.setDouble(key, value as double);
    }
  }

  T _getPref<T>(String key) {
    return _prefsInstance.get(key) as T;
  }

  void clearAll() {
    var token = getFcmToken();
    final favs = _prefsInstance.getStringList(_favIdsKey);
    _prefsInstance.clear();
    saveFcmToken(token);

    if (favs != null) {
      _prefsInstance.setStringList(_favIdsKey, favs);
    }
  }

  void clearAllExceptFirstLaunch() {
    final firstLaunchValue = getFirstLaunch();

    _prefsInstance.clear();
    saveFirstLaunch(firstLaunchValue);
  }


  String? getFcmToken() {
    return _getPref(_FcmToken);
  }

  void saveFcmToken(String? token) {
    _savePref(_FcmToken, token);
    _savePref(_FcmToken, token);
  }

  void saveFirstName(String? fName) {
    _savePref(firstName, fName);
  }

  String? getFirstName() {
    return _getPref(firstName);
  }

  void saveLastName(String? lName) {
    _savePref(lastName, lName);
  }

  String? getLastName() {
    return _getPref(lastName);
  }

  void saveEmail(String? email) {
    _savePref(emailId, email);
  }

  String? getEmail() {
    return _getPref(emailId);
  }


  void saveDateOfBirth(String? db) {
    _savePref(dob, db);
  }

  String? getDateOfBirth() {
    return _getPref(dob);
  }


  int? getUserId() {
    return _getPref(_userId);
  }

  int? getSubscriptionId() {
    return _getPref(_subscriptionId);
  }

  void saveUserId(int? userId) {
    _savePref(_userId, userId);
  }

  void saveSubscriptionId(int? subscriptionId) {
    _savePref(_subscriptionId, subscriptionId);
  }

  bool? getAcc() {
    return _getPref(_createAcc);
  }

  void saveAcc(bool? acc) {
    _savePref(_createAcc, acc ?? false);
  }

  int? getUserType() {
    return _getPref(_userType);
  }

  String? getType() {
    return _getPref(_type);
  }

  String? phone() {
    return _getPref(_phone);
  }

  void saveType(String? type) {
    _savePref(_type, type);
  }

  void savephone(String? phone) {
    _savePref(_phone, phone);
  }

  void saveFirstLaunch(bool value) {
    _prefsInstance.setBool(isFirstLaunch, value);
  }

  bool getFirstLaunch() {
    final value = _prefsInstance.getBool(isFirstLaunch);
    return value ?? true;
  }

  int? getActiveChatId() {
    return _getPref(_activeChatId);
  }

  void saveShowDialog(bool? dialog) {
    _savePref(_showDialog, dialog);
  }

  bool? getShowDialog() {
    return _getPref(_showDialog);
  }

  void saveActiveChatId(int? userId) {
    _savePref(_activeChatId, userId);
  }

  String? getUserToken() {
    return _getPref(_userToken);
  }

  void saveUserToken(String? token) {
    _savePref(_userToken, token);
  }

  void saveUserType(int? userType) {
    _savePref(_userType, userType);
  }
}
