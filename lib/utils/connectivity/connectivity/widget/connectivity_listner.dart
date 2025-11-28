import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/network/network/service_locator.dart';

import '../network_connection_observer.dart';
import '../screen/no_internet_screen.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;
  ConnectivityListener({super.key, required this.child});

  final NetworkConnectionObserver network = getIt.get<NetworkConnectionObserver>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: network.connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          return child;
        }

        final isConnected =
        !(snapshot.data?.contains(ConnectivityResult.none) ?? true);

        if (isConnected) {
          return child;
        }

        return NoInternetScreen();
      },
    );
  }
}