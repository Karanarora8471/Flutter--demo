import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/local_storage/local_storage/local_storage_constant.dart';
import 'package:flutter_demo/utils/local_storage/local_storage/shared_preferences.dart';
import 'package:flutter_demo/utils/network/network/service_locator.dart';


import 'notification_service.dart';


// class NotificationServiceHelper extends NotificationService {
//   static NotificationServiceHelper? _instance;
//   GlobalKey<NavigatorState>? _globalKey;
//
//   NotificationServiceHelper._() : super(notificationIcon: 'ic_stat_name',channelId: '1');
//
//   static NotificationServiceHelper get instance =>
//       _instance ??= NotificationServiceHelper._();
//
//   @override
//   void setGlobalNavigationKey(GlobalKey<NavigatorState> globalKey) {
//     _instance!._globalKey = globalKey;
//   }
//
//   @override
//   void saveFCMToken(String? token) {
//     log('FCM Token: $token');
//     getIt.get<SharedPreferencesService>().setString(LocalStorageConstant.fcmTokenKey,token??'');
//   }
//
//
//
//
// }
