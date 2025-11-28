import 'package:flutter/material.dart';

class Utils {

  static void printLog(message) {
    /*  if(kDebugMode){
      debugPrint("******************************************************\n*\n*\n");
      debugPrint(message.toString());
      debugPrint("n*\n*\n******************************************************");
    }*/
    print("***************************************\n*\n*");
    print(message.toString());
    print("\n*\n**************************************");
  }

  static hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String capitalize(String s) {
    return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
  }
}
