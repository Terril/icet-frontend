import 'package:get_storage/get_storage.dart';
import 'package:icet/extension/ext.dart';

/**
  GetStorage is part of GetX, The bad thing it doesn't support bool yet
*/
mixin CacheManager {

  void saveToken(String? token) {
    var storage = GetStorage("icet-pref");
    storage.write(CacheManagerKey.TOKEN.name, filterNull(token));
  }

  String? getToken() {
    var storage = GetStorage("icet-pref");
    var token = storage.read(CacheManagerKey.TOKEN.name);
    return token;
  }

  Future<void> removeToken() async {
    var storage = GetStorage("icet-pref");
    storage.remove(CacheManagerKey.TOKEN.name);
  }

  // Can be any number except 0
  void saveLoginState(bool state) {
    var storage = GetStorage("icet-pref");
    storage.write(CacheManagerKey.LOGIN.name, state.toString());
  }

  bool? getLoginState() {
    var storage = GetStorage("icet-pref");
    String storageValue = storage.read(CacheManagerKey.LOGIN.name);
    return storageValue ==  "true" ? true : false;
  }
}

enum CacheManagerKey { TOKEN, LOGIN }
