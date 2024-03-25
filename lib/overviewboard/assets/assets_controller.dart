
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/provider/apiServiceProvider.dart';

class AssetsController extends GetxController with CacheManager {
  late APIServiceProvider provider;

  @override
  void onInit() {
    super.onInit();
    provider = APIServiceProvider();
    provider.getApiBoardsCustom();
  }

  void createBoard() {}

  void fetchAssets() {}

  void createAssets() {}

  void fetchChecklists() {}

}
