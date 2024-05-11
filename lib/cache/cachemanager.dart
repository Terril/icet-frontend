import 'package:get_storage/get_storage.dart';
import 'package:icet/extension/ext.dart';

/**
  GetStorage is part of GetX, The bad thing it doesn't support bool yet
*/
mixin CacheManager {

  static const String STORAGE_CONTAINER = "icet-pref";
  void saveToken(String? token) {
    var storage = GetStorage(STORAGE_CONTAINER);
    storage.write(CacheManagerKey.TOKEN.name, filterNull(token));
  }

  String? getToken() {
    var storage = GetStorage(STORAGE_CONTAINER);
    var token = storage.read(CacheManagerKey.TOKEN.name);
    return token;
  }

  Future<void> removeAll() async {
    var storage = GetStorage(STORAGE_CONTAINER);
    storage.erase();
  }

  // Can be any number except 0
  void saveLoginState(bool state) {
    var storage = GetStorage(STORAGE_CONTAINER);
    storage.write(CacheManagerKey.LOGIN.name, state.toString());
  }

  bool? getLoginState() {
    var storage = GetStorage(STORAGE_CONTAINER);
    String storageValue = storage.read(CacheManagerKey.LOGIN.name);
    return storageValue ==  "true" ? true : false;
  }

  void saveLoginEmail(String email) {
    var storage = GetStorage(STORAGE_CONTAINER);
    storage.write(CacheManagerKey.USER_EMAIL.name, email);
  }

  String? getLoginEmail() {
    var storage = GetStorage(STORAGE_CONTAINER);
    var email = storage.read(CacheManagerKey.USER_EMAIL.name);
    return email;
  }
}

enum CacheManagerKey { TOKEN, LOGIN, USER_EMAIL }
