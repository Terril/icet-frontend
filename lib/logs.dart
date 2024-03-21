
class Logger {
  static const bool _enableLog = true;

  static printLog({String tag = "", required String message}) {
    if (_enableLog) {
      print("TAG :$tag $message");
    }
  }
}
