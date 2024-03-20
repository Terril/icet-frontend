
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/extension/ext.dart';

class Auth with CacheManager {

  Future<bool> isLogged() async {
    try {
      // Obtain shared preferences.
      return getLoginState().then((value) =>
           filterBoolNull(value)
      );
    } catch (e) {
      return false;
    }
  }
}