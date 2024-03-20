
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/extension/ext.dart';

class Auth with CacheManager {

  Future<bool> isLogged() async {
    initSharedPreference();
    try {
      // Obtain shared preferences.
      var isLoggedIn = getLoginState();
      return filterBoolNull(isLoggedIn);
    } catch (e) {
      return false;
    }
  }
}