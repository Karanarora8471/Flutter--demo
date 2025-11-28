// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
//
// import 'package:flutter_demo/utils/connectivity/connectivity/network_connection_observer.dart';
// import 'package:flutter_demo/utils/local_storage/local_storage/local_storage_constant.dart';
// import 'package:flutter_demo/utils/local_storage/local_storage/shared_preferences.dart';
// import 'package:flutter_demo/utils/network/network/service_locator.dart';
//
// import 'api_exception.dart';
// import 'dart:async';
//
// typedef UploadProgressCallback = void Function(double progress);
//
// abstract class DioBaseService {
//   CancelToken _cancelToken = CancelToken();
//   late Dio _dioClient;
//   late String _baseUrl;
//
//   final NetworkConnectionObserver network =
//       getIt.get<NetworkConnectionObserver>();
//
//   DioBaseService(String baseUrl) {
//     _baseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
//     _createClient();
//   }
//
//   @protected
//   Map<String, dynamic> getHeader() {
//     final SharedPreferencesService sharedPrefs =
//         getIt.get<SharedPreferencesService>();
//     final token = sharedPrefs.getString(LocalStorageConstant.authTokenKey, defaultValue: '');
//     return {
//       "Content-Type": "application/json",
//       "Authorization": token.isNotEmpty ? "Bearer $token" : "",
//       // "Authorization":
//       //     "Bearer ${sharedPrefs.getString(LocalStorageConstant.authTokenKey, defaultValue: '')}" ??
//       //         "",
//     };
//   }
//
//   void _createClient() {
//     _dioClient = Dio();
//     _dioClient.options
//       ..baseUrl = _baseUrl
//       ..connectTimeout = const Duration(seconds: 20)
//       ..sendTimeout = const Duration(seconds: 20)
//       ..receiveTimeout = const Duration(seconds: 20)
//       ..headers = getHeader()
//       ..responseType = ResponseType.plain;
//
//     // _dioClient.interceptors.add(RefreshTokenInterceptor(_dioClient));
//     _dioClient.interceptors.add(LogInterceptor(
//         requestBody: true,
//         error: true,
//         requestHeader: true,
//         responseHeader: false,
//         responseBody: true,
//         request: false));
//   }
//
//   @protected
//   Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
//     try {
//       if (network.offline) {
//         throw ConnectionException("Internet Not Available");
//       }
//
//       Response response = await _dioClient.get(path,
//           queryParameters: queryParams,
//           options: Options(headers: getHeader()),
//           cancelToken: _cancelToken);
//
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       _errorHandler(dioError);
//     }
//   }
//
//   @protected
//   Future<dynamic> getWithBody(String path, {Map<String, dynamic>? body}) async {
//     try {
//       if (network.offline) {
//         throw ConnectionException("Internet Not Available");
//       }
//
//       Response response = await _dioClient.request(
//         path,
//         data: body,
//         options: Options(
//           method: 'GET',
//           headers: getHeader(),
//         ),
//         cancelToken: CancelToken(),
//       );
//
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       _errorHandler(dioError);
//     }
//   }
//
//
//   @protected
//   Future<dynamic> post(String path, Map<String, dynamic> data,
//       {newData}) async {
//     try {
//       if (network.offline) {
//         throw ConnectionException("Internet Not Available");
//       }
//
//       Response response = await _dioClient.post(path,
//           queryParameters: data,
//           data: newData ?? FormData.fromMap(data),
//           options: Options(headers: getHeader()),
//           cancelToken: _cancelToken);
//
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       _errorHandler(dioError);
//     } catch (e, stackTrace) {
//       print("e ${e} stackTrace${stackTrace}");
//       return Future.error(e);
//     }
//   }
//
//   Future<dynamic> postFormDataWithImage({
//     required String path,
//     required Map<String, dynamic> fields,
//     File? imageFile,
//     String imageFieldKey = "docImage",
//   }) async {
//     try {
//       if (network.offline) {
//         throw ConnectionException("Internet Not Available");
//       }
//
//       FormData formData = FormData();
//
//       // Add text fields
//       fields.forEach((key, value) {
//         formData.fields.add(MapEntry(key, value.toString()));
//       });
//
//       // Add image if provided
//       if (imageFile != null) {
//         String fileName = imageFile.path.split("/").last;
//         formData.files.add(
//           MapEntry(
//             imageFieldKey,
//             await MultipartFile.fromFile(imageFile.path, filename: fileName),
//           ),
//         );
//       }
//
//       Response response = await _dioClient.post(
//         path,
//         data: formData,
//         options: Options(headers: getHeader()),
//         cancelToken: _cancelToken,
//       );
//
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       _errorHandler(dioError);
//     } catch (e) {
//       log("Error posting form data with image: $e");
//       return Future.error(e);
//     }
//   }
//
//   Future<dynamic> uploadImage(String path, File imageFile,
//       UploadProgressCallback progressCallback) async {
//     try {
//       if (network.offline) {
//         throw ConnectionException("Internet Not Available");
//       }
//
//       String fileName = imageFile.path.split('/').last;
//       FormData formData = FormData.fromMap({
//         "image": await MultipartFile.fromFile(
//           imageFile.path,
//           filename: fileName,
//         ),
//       });
//
//       Response response = await _dioClient.post(path, data: formData,
//           onSendProgress: (int sent, int total) {
//         double progress = sent / total;
//         progressCallback(progress);
//         print("Upload Progress: ${progress.toStringAsFixed(2)}%");
//       }, cancelToken: _cancelToken, options: Options(headers: getHeader()));
//
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       _errorHandler(dioError);
//     }
//   }
//
//   @protected
//   Future<dynamic> postJson(String path, {Map<String, dynamic>? data}) async {
//     try {
//       if (network.offline) {
//         throw ConnectionException("Internet Not Available");
//       }
//
//       Response response = await _dioClient.post(path,
//           data: jsonEncode(data),
//           options: Options(headers: getHeader(),
//             responseType: ResponseType.json,
//           ),
//           cancelToken: _cancelToken);
//
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       final handledError = _errorHandler(dioError);
//       return Future.error(handledError);
//      // _errorHandler(dioError);
//     } catch (e, stackTrace) {
//       print("post error ${e} stackTrace${stackTrace}");
//       return Future.error(e);
//     }
//   }
//
//
//
//   @protected
//   Future<dynamic> put(
//     String path,
//     Map<String, dynamic> data,
//   ) async {
//     try {
//       if (network.offline) {
//         throw ConnectionException("Internet Not Available");
//       }
//       Response response = await _dioClient.put(path,
//           data: data,
//           options: Options(headers: getHeader()),
//           cancelToken: _cancelToken);
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       _errorHandler(dioError);
//     }
//   }
//
//   @protected
//   Future<dynamic> delete(String path, {Map<String, dynamic>? data}) async {
//     try {
//       Response response = await _dioClient.delete(path,
//           data: data,
//           cancelToken: _cancelToken,
//           options: Options(headers: getHeader()));
//       return _responseHandler(response);
//     } on DioException catch (dioError) {
//       _errorHandler(dioError);
//     }
//   }
//
//   Future<Map<String, dynamic>> deleteData(String path, {Map<String, dynamic>? data}) async {
//     try {
//       final response = await _dioClient.request(
//         path,
//         data: data,
//         options: Options(
//           method: 'DELETE',
//           headers: {
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       if (response.data is Map<String, dynamic>) {
//         return response.data;
//       } else if (response.data is String) {
//         return json.decode(response.data);
//       } else {
//         throw FormatException("Unexpected response type");
//       }
//     } on DioException catch (e) {
//       _errorStatus(e);
//       rethrow;
//     }
//   }
//
//
//
//
//   Map<String, dynamic> _errorHandler(DioException error) {
//     print('----_errorHandler----$error');
//
//     DioExceptionType dioExceptionType = error.type;
//
//     final responseData = error.response?.data;
//
//     final statusCode = error.response?.statusCode ?? 500;
//
//     String message = 'Something went wrong';
//     if (responseData is Map && responseData['message'] != null) {
//       message = responseData['message'];
//     }
//     else if (responseData is String) {
//       try {
//         final jsonData = jsonDecode(responseData);
//         message = jsonData['error']['message'] ?? message;
//
//         ///  Handle 'wrong Token' error
//         if (statusCode == 500 && message == 'Access denied. wrong Token') {
//           _handleUnauthorizedToken();
//         }
//       } catch (_) {}
//     }
//
//     switch (dioExceptionType) {
//       case DioExceptionType.connectionTimeout:
//         message = 'Connection timed out';
//         break;
//       case DioExceptionType.sendTimeout:
//         message = 'Request timed out';
//         break;
//       case DioExceptionType.receiveTimeout:
//         message = 'Response timed out';
//         break;
//       case DioExceptionType.badResponse:
//         message = 'Bad response';
//         break;
//       case DioExceptionType.badCertificate:
//         message = 'Bad certificate';
//         break;
//       case DioExceptionType.cancel:
//         message = 'Request cancelled';
//         break;
//       case DioExceptionType.unknown:
//         if (error.error is SocketException) {
//           message = 'Socket error';
//         } else {
//           message = 'Unknown error';
//         }
//         break;
//       case DioExceptionType.connectionError:
//         message = 'Connection error';
//         break;
//       }
//
//     return {
//       'success': false,
//       'message': message,
//       'status': error.response?.statusCode ?? 500,
//     };
//   }
//   void _handleUnauthorizedToken() async {
//     final SharedPreferencesService sharedPrefs =
//     getIt.get<SharedPreferencesService>();
//
//     // Clear saved token
//     await sharedPrefs.clearAllExceptFirstLaunch(LocalStorageConstant.authTokenKey);
//
//     // Navigate to login
//     NavigationService.navigatorKey.currentState?.pushNamedAndRemoveUntil(
//       RoutesGenerator.loginRoute,
//           (route) => false,
//     );
//   }
//
//   dynamic _responseHandler(Response response) {
//     //print('----f_responseHandler----f =${response}');
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//       case 202:
//       case 203:
//         if (response.data == null || response.data.isEmpty) {
//           throw EmptyResultApiException();
//         }
//         return response.data;
//     }
//   }
//
//   void _errorStatus(DioException dioException) {
//     ErrorResponseModel? errorResponseModel;
//     if (dioException.response?.data != null) {
//       errorResponseModel =
//           ErrorResponseModel.fromJson(jsonDecode(dioException.response!.data));
//     }
//
//     switch (dioException.response?.statusCode) {
//       case 400:
//         throw BadRequestException(errorResponseModel?.error ?? "");
//       case 422:
//         throw BadRequestException(errorResponseModel?.error ?? "");
//       case 401:
//         throw BadResponseException(errorResponseModel?.error ?? '');
//       case 403:
//         throw UnauthorisedException(errorResponseModel?.error?.toString());
//       case 404:
//         if (errorResponseModel?.error != null) {
//           throw CustomNotFoundException(errorResponseModel?.error ?? "",
//               data: errorResponseModel?.error);
//         } else {
//           throw NotFoundException(errorResponseModel?.error ?? "");
//         }
//       case 500:
//       default:
//         throw FetchDataException(dioException.response?.statusCode != null
//             ? 'Error occured while Communication with Server with StatusCode : ${dioException.response?.statusCode ?? ''}'
//             : 'Error occured while Communication with Server');
//     }
//   }
// }
