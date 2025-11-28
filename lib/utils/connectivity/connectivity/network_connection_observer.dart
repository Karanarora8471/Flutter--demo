import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'connection.dart';

class NetworkConnectionObserver extends ChangeNotifier {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  late Stream<List<ConnectivityResult>> connectivityStream;


  Connection connection = Connection.Disconnected;
  bool offline = true;

  NetworkConnectionObserver() {
    subscription = Connectivity().onConnectivityChanged.listen(connectivityChanged);
    connectivityStream = Connectivity().onConnectivityChanged;
    checkConnectivity();
  }

  void connectivityChanged(List<ConnectivityResult> results) {
    print('Connectivity changed to: $results');

    Connection value = Connection.Disconnected;

    if (results.contains(ConnectivityResult.wifi)) {
      value = Connection.Wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      value = Connection.MobileData;
    }

    setConnection(value);
  }

  void setConnection(Connection value) {
    if (value != connection) {
      offline = value != Connection.MobileData && value != Connection.Wifi;
      connection = value;
      notifyListeners();
    }
  }

  Future<void> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();

    connectivityChanged(connectivityResults);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
