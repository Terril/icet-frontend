
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/logs.dart';
import 'package:icet/provider/apiServiceProvider.dart';

import '../../datamodel/columns.dart';

class AssetsController extends GetxController with CacheManager {
  late APIServiceProvider provider;

  @override
  void onInit() {
    super.onInit();
    provider = APIServiceProvider();
  }

  void createBoard() {}

  Future<List<Columns?>> fetchColumns(String? boardId) async {
    Response response = await provider.getColumnsByBoardId(boardId);
    Logger.printLog(message: "${response.bodyString}");
    List<Columns> responseBoards = ColumnList.fromJsonToList(response.body).list;

    Logger.printLog(message: "${response.bodyString}");
    return responseBoards;
  }

  void createAssets() {}

  void fetchChecklists() {}

}
