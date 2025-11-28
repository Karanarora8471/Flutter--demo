// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
//
// class DbHelper {
//   DbHelper._();
//   static GetStorage box = GetStorage();
//   static const JsonDecoder _decoder = JsonDecoder();
//   static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');
//   static DbHelper get instance => _instance;
//   factory DbHelper() {
//     return _instance;
//   }
//
//   static final DbHelper _instance = DbHelper._();
//   final String _userModel = "userModel";
//   final String _userId = "userId";
//   final String _token = "token";
//   final String _type = "type";
//   final String _userType = "userType";
//   final String _phone = "phone";
//   final String _isLoggedIn = "isLoggedIn";
//   final String _hasStripeConnected = "hasStripeConnected";
//   final String _userLat = "userLat";
//   final String _userLong = "userLong";
//
//   static writeData(String key, dynamic value) async {
//     await box.write(key, value);
//   }
//
//   static readData(String key) {
//     return box.read(key);
//   }
//
//   static deleteData(String key) async {
//     await box.remove(key);
//   }
//
//   static eraseData() async {
//     await box.erase();
//   }
//
//   // void saveUserModel(UserModel? model) {
//   //   if (model != null) {
//   //     String value = _encoder.convert(model);
//   //     writeData(_userModel, value);
//   //   } else {
//   //     writeData(_userModel, null);
//   //   }
//   // }
//
//   bool getIsLoggedIn() {
//     return readData(_isLoggedIn) ?? false;
//   }
//
//   String getType() {
//     return readData(_type);
//   }
//
//   void saveType(String? type) {
//     writeData(_type, type);
//   }
//
//   int getUserType() {
//     return readData(_userType);
//   }
//
//   void saveUserType(int type) {
//     writeData(_userType, type);
//   }
//
//   void saveIsLoggedIn(bool value) {
//     writeData(_isLoggedIn, value);
//   }
//
//   bool getIsStripeConnected() {
//     return readData(_hasStripeConnected) ?? false;
//   }
//
//   void saveStripeConnected(bool value) {
//     writeData(_hasStripeConnected, value);
//   }
//
//   void saveUserLatitude(double? value) {
//     writeData(_userLat, value);
//   }
//
//   double getUserLatitude() {
//     return readData(_userLat);
//   }
//
//   void saveUserLongitude(double value) {
//     writeData(_userLong, value);
//   }
//
//   double getUserLongitude() {
//     return readData(_userLong);
//   }
//
//   // UserModel? getUserModel() {
//   //   String? user = readData(_userModel);
//   //   if (user != null) {
//   //     Map<String, dynamic> userMap = _decoder.convert(user);
//   //     return UserModel.fromJson(userMap);
//   //   } else {
//   //     return null;
//   //   }
//   // }
//
//   void saveUserId(
//     num? userId,
//   ) {
//     writeData(_userId, userId);
//   }
//
//   num? getUserId() {
//     return readData(_userId);
//   }
//
//   void saveToken(String? token) {
//     writeData(_token, token);
//   }
//
//   String? getToken() {
//     return readData(_token);
//   }
// }
//
// /*class KeysDbHelper {
//   static String isLogin = "isLogin";
//   static String id = "id";
//   static String name = "name";
//   static String image = "image";
//   static String email = "email";
//   static String password = "password";
//   static String phoneNo = "phoneNo";
//   static String age = "age";
//   static String gender = "gender";
//   static String occupation = "occupation";
//   static String idProof = "idProof";
//   static String location = "location";
//   static String forgotPasswordHash = "forgotPasswordHash";
//   static String latitude = "latitude";
//   static String longitude = "longitude";
//   static String role = "role";
//   static String status = "status";
//   static String verifyOtp = "verifyOtp";
//   static String otpCode = "otpCode";
//   static String isNotification = "isNotification";
//   static String isVerified = "isVerified";
//   static String deviceType = "deviceType";
//   static String deviceToken = "deviceToken";
//   static String loginTime = "loginTime";
//   static String createdAt = "createdAt";
//   static String updatedAt = "updatedAt";
//   static String token = "token";
// }*/
