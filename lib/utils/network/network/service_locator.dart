

import 'package:flutter_demo/utils/connectivity/connectivity/network_connection_observer.dart';
import 'package:flutter_demo/utils/local_storage/local_storage/shared_preferences.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.I;

Future<void> serviceLocator() async {
  getIt.registerSingleton<NetworkConnectionObserver>(
      NetworkConnectionObserver());
   //getIt.registerSingleton<Language>(Language());
  SharedPreferencesService sharedPrefs =
  await SharedPreferencesService.getInstance();
  getIt.registerSingleton<SharedPreferencesService>(sharedPrefs);
}
