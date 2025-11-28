// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LocationHelper {
//   Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw 'Location services are disabled.';
//     }
//
//     // Check location permission status
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       throw 'Location permissions are permanently denied, we cannot request permissions.';
//     }
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         if (permission == LocationPermission.deniedForever) {
//           showDialog(
//             context: Get.context!,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text('Location Permission Required'),
//                 content: const Text(
//                     'This app use your location to show near by products and services.'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('CANCEL'),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       Navigator.of(context).pop();
//                       if (permission == LocationPermission.deniedForever) {
//                         await openAppSettings();
//                       } else {
//                         permission = await Geolocator.requestPermission();
//                       }
//                     },
//                     child: const Text('Grant Permission'),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       Navigator.of(context).pop();
//                       await openAppSettings();
//                     },
//                     child: const Text('OPEN SETTINGS'),
//                   ),
//                 ],
//               );
//             },
//           );
//           throw 'Location permissions are permanently denied, we cannot request permissions.';
//         }
//         throw 'Location permissions are denied (actual value: $permission).';
//       }
//     }
//
//     // Get current position
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
//
//   Future<String> getAddressFromCoordinates(
//       double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//       Placemark place = placemarks.first;
//       return "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//     } catch (e) {
//       return "Unable to get address for the provided coordinates.";
//     }
//   }
// }
