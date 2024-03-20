import 'package:icet/extension/ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CacheManager {
  SharedPreferences? preferences;

  void initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  bool saveToken(String? token) {
    preferences?.setString(CacheManagerKey.TOKEN.name, filterNull(token));
    return true;
  }

  String? getToken() {
    var token = preferences?.getString(CacheManagerKey.TOKEN.name);
    return token;
  }

  Future<void> removeToken() async {
    preferences?.remove(CacheManagerKey.TOKEN.name);
  }

  // Can be any number except 0
  Future<void> saveLoginState(bool state) async {
    preferences?.setBool(CacheManagerKey.LOGIN.name, state);
  }

  bool? getLoginState() {
    return preferences?.getBool(CacheManagerKey.LOGIN.name);
  }
}

enum CacheManagerKey { TOKEN, LOGIN }
