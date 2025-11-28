//
//
// import 'package:dio/dio.dart';
//
// class RefreshTokenInterceptor extends Interceptor {
//   final Dio _dio;
//   bool isRefreshing = false;
//
//   RefreshTokenInterceptor(this._dio);
//
//   String refreshTokenEndPoint = "/customer-authentication/refresh-customer-token";
//
//
//   @override
//   Future<dynamic> onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     // Add the access token to the request headers
//     // final accessToken = await hiveDbHelper.getAccessToken();
//     // options.headers['Authorization'] = 'Bearer ${accessToken??""}';
//     //
//     // return super.onRequest(options, handler);
//   }
//
//
//
//
//   @override
//   Future<dynamic> onError(
//       DioException error, ErrorInterceptorHandler handler) async {
//     // Check if the error is due to an expired access token
//     /*if (error.response?.statusCode == 401) {
//       // Refresh the access token
//       if (isRefreshing == false && AppConstant.isLoggedIn==true) {
//         final newAccessToken = await refreshAccessToken();
//         // Retry the failed request with the new access token
//           if (newAccessToken != null) {
//           error.requestOptions.headers['Authorization'] = 'Bearer ${newAccessToken??""}';
//           var response=  await  _dio.request<dynamic>(
//             error.requestOptions.path,
//             cancelToken: error.requestOptions.cancelToken,
//             data: error.requestOptions.data,
//             options: Options(
//               method: error.requestOptions.method,
//               headers: error.requestOptions.headers,),
//           );
//           return handler.resolve(response);
//         }
//       }
//     }
// */
//     return super.onError(error, handler);
//   }
// /*
//   Future<String> refreshAccessToken()  async{
//     isRefreshing = true;
//     try {
//       var response = await _dio.get(
//           Environment().config.apiHost+refreshTokenEndPoint);
//       if (response != null) {
//         RefreshTokenResponseModel responseModel = RefreshTokenResponseModel
//             .fromJson(jsonDecode(response?.data));
//         if (responseModel?.data != null) {
//           final newAccessToken = responseModel.data?.accessToken;
//           HiveDatabaseHelper hiveDatabaseHelper = HiveDatabaseHelper();
//           hiveDatabaseHelper.addAccessToken(newAccessToken);
//           isRefreshing = false;
//           return newAccessToken;
//         }
//       }
//     }catch (e) {
//       print("exception ${e}");
//       _logoutUser();
//       return Future.error(e);
//     }
//   }
//
//   _logoutUser() async {
//     SharedPrefs.setUserLoggedIn(false);
//     SharedPrefs.removeUser();
//     SharedPrefs.removeKey(AppConstant.showReferEarnAlert);
//     SharedPrefs.removeKey(AppConstant.referEarnMsg);
//     SharedPrefs.removeKey("user");
//     SingletonBrandData.getInstance().clearData();
//     AppConstant.isLoggedIn = false;
//     HiveDatabaseHelper hivedbHelper = HiveDatabaseHelper();
//     await hivedbHelper.deleteTable(HiveDatabaseHelper.storeDataBox);
//
//     await hivedbHelper.deleteTable(HiveDatabaseHelper.userAccessTokenBox);
//     await hivedbHelper.deleteTable(HiveDatabaseHelper.cartBox);
//     await hivedbHelper.deleteTable(HiveDatabaseHelper.favoriteBox);
//     await hivedbHelper.deleteTable(HiveDatabaseHelper.addressBox);
//     eventBus.fire(updateCartCount());
//     eventBus.fire(onCartRemoved());
//     isRefreshing = false;
//     Navigator.of(mainGlobalKey.currentContext)
//         .popUntil((route) => route.isFirst);
//     Utils.showToast(AppConstant.logoutSuccess, true);
//
//   }*/
// }
