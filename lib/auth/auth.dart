
import 'package:icet/cache/cachemanager.dart';

class Auth with CacheManager {

  Future<bool> isLogged() async {
    try {
      final bool isLoggedIn = getLoginState();
      return isLoggedIn;
    } catch (e) {
      return false;
    }
  }
}