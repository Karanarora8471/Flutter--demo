// import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/bin/common_patch.dart' as IO;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_demo/utils/logger/environments/environments/environment.dart';
// import 'dart:collection';
//
// import 'package:flutter_demo/utils/utils/utils/helper/shared_preference.dart';
//
//
//
//
// class SocketHelper {
//   static final SocketHelper _singleton = SocketHelper._internal();
//
//   SocketHelper._internal();
//
//   factory SocketHelper() => _singleton;
//
//   late IO.Socket _socketIO;
//
//   bool isConnected = false, isUserConnected = false;
//
//   late SharedPreferenceHelper preferenceHelper;
//
//   IO.Socket getSocket() => _socketIO;
//
//   void init() {
//     preferenceHelper = SharedPreferenceHelper();
//     _socketIO = IO.io(
//       Environment().config.apiHost,
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableAutoConnect()
//           .enableReconnection()
//           .setReconnectionAttempts(5)
//           .setReconnectionDelay(2000)
//           .setExtraHeaders({'forceNew': true})
//           .build(),
//     );
//     _initListener();
//   }
//
//   void _initListener() {
//     _socketIO.onConnect((data) {
//       isConnected = true;
//       debugPrint('socket connected');
//
//       if (preferenceHelper.getUserId() != null) {
//         connectUser();
//       }
//     });
//
//     _socketIO.onDisconnect((data) {
//       isConnected = false;
//       isUserConnected = false;
//       debugPrint('socket disconnected');
//       reconnectUser();
//     });
//
//     _socketIO.onConnectError((data) {
//       isConnected = false;
//       debugPrint('connect error: ${data.toString()}');
//     });
//
//     _socketIO.onError((data) {
//       debugPrint('socket error: ${data.toString()}');
//     });
//
//     _socketIO.on("connected_listener", (data) {
//       isUserConnected = true;
//       debugPrint("user connected: $data");
//     });
//
//     _socketIO.on("disconnect_listener", (data) {
//       isUserConnected = false;
//       debugPrint("user disconnected: $data");
//     });
//   }
//
//   void connectUser() {
//     if (preferenceHelper.getUserId() != null) {
//       Map<String, dynamic> map = HashMap();
//       map['user_id'] = preferenceHelper.getUserId();
//       _socketIO.emit("connect_user", map);
//       debugPrint("connect_user emit map: $map");
//     }
//   }
//
//   void disconnectUser() {
//     debugPrint("User manually disconnected");
//     _socketIO.off("connect_user");
//     Map<String, dynamic> map = HashMap();
//     map['userId'] = preferenceHelper.getUserId();
//     _socketIO.emit("disconnect_user", map);
//   }
//
//   void reconnectUser() {
//     if (!isConnected) {
//       debugPrint('Attempting to reconnect socket...');
//       _socketIO.connect();
//     }
//   }
//
//
//
//   // Future<void> emitEvent({
//   //   required Map<String, dynamic>? dataBody,
//   //   required String eventName,
//   // }) async {
//   //   if (dataBody == null) {
//   //     throw ArgumentError('dataBody must not be null');
//   //   }
//   //   if (_socketIO != null && _socketIO.connected) {
//   //     _socketIO.emit(eventName, json.encode(json.decode(dataBody.toString())));
//   //     print(json.encode(json.decode(dataBody.toString())));
//   //   }
//   // }
//
//
//   /// map according pass the data value of the response
//   Future<void> emitEvent({
//     required Map<String, dynamic>? dataBody,
//     required String eventName,
//   }) async {
//     if (dataBody == null) {
//       throw ArgumentError('dataBody must not be null');
//     }
//
//     if (_socketIO != null && _socketIO.connected) {
//       _socketIO.emit(eventName, dataBody);
//       print('Emitted to $eventName: ${json.encode(dataBody)}');
//     } else {
//       print('Socket not connected');
//     }
//   }
//
//
//
//   Future<void> listenEvent({
//     required String eventName,
//     required Function(dynamic) onDataReceived,
//   }) async {
//     if (_socketIO != null && _socketIO.connected) {
//       _socketIO.on(eventName, onDataReceived);
//     }
//   }
//
//   Future<void> disconnectSocket() async {
//     _socketIO.disconnect();
//   }
//
//   void joinRoom({required String eventName,required String roomId}) {
//     Map<String, dynamic> map = {'roomId': roomId};
//     _socketIO.emit(eventName, map);
//     debugPrint("$eventName: $map");
//   }
//
//   void leaveRoom({required String eventName,required String roomId}) {
//     Map<String, dynamic> map = {'roomId': roomId};
//     _socketIO.emit(eventName, map);
//     debugPrint("$eventName: $map");
//   }
// }
//
//
