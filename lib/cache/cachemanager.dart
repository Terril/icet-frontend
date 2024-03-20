import 'package:icet/extension/ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(CacheManagerKey.TOKEN.name, filterNull(token));
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(CacheManagerKey.TOKEN.name);
  }

  Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(CacheManagerKey.TOKEN.name);
  }

  // Can be any number except 0
  Future<void> saveLoginState(bool state) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(CacheManagerKey.LOGIN.name, state);
  }

  Future<bool?> getLoginState() async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(CacheManagerKey.LOGIN.name);
  }
}


enum CacheManagerKey { TOKEN, LOGIN }
