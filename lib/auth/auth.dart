
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/extension/ext.dart';
import 'package:icet/logs.dart';

class Auth with CacheManager {

  Future<bool> isLogged() async {
    try {
      // Obtain shared preferences.
      var isLoggedIn = getLoginState();
      return filterBoolNull(isLoggedIn);
    } catch (e) {
      Logger.printLog(message: "Is an Exception");
      return false;
    }
  }
}