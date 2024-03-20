import 'dart:developer';

class Logger {
  static bool enableLog = true;

  static printLog({String tag = "", required String message}) {
    if (enableLog) {
      print("TAG :$tag $message");
    }
  }
}
