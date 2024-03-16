import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  Future<void> saveLoginState(bool state) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.LOGIN.toString(), state);
  }

   bool getLoginState() {
    final box = GetStorage();
    return box.read(CacheManagerKey.LOGIN.toString()) ?? false;
  }
}


enum CacheManagerKey { TOKEN, LOGIN }
