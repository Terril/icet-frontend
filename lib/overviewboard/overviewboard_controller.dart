
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/logs.dart';
import 'package:icet/provider/apiServiceProvider.dart';

import '../datamodel/boards.dart';

class OverviewboardController extends GetxController with CacheManager {
  late APIServiceProvider overviewboardProvider;

  final selected = "1".obs;

  RxInt obxPosition = 0.obs;

  late Future futureBoard;

  List<String> get dropdownItems {
    List<String> menuItems = [
      "1",
      "2",
      "3",
      "4",
      "5",
    ];
    return menuItems;
  }

  @override
  void onInit() {
    super.onInit();
    overviewboardProvider = APIServiceProvider();
    futureBoard = fetchBoard();
  }

  void selectDrawer(int position) {
    obxPosition.value = position;
  }

  void setSelected(String value) {
    selected.value = value;
  }


  Future<List<Boards?>> fetchBoard() async {
    Response response = await overviewboardProvider.getBoard();
    List<Boards> responseBoards = BoardList.fromJsonToList(response.body).list;

    Logger.printLog(message: "${response.bodyString}");
    return responseBoards;
  }

  void callCustomBoard() async {
    Response response = await overviewboardProvider.getApiBoardsCustom();
    Logger.printLog(message: "${response.bodyString}");
    if (response != null) {
      futureBoard = fetchBoard();
    }

    update();
    Boards responseBoards = Boards.fromJson(response.body);
  }


  int? getItemCount(int?  itemCount) {
   if(itemCount == null) return 1;

   if(itemCount > 0) { return itemCount + 1 ; }
  }

  void createBoard() {}

  void fetchAssets() {}

  void createAssets() {}

  void fetchChecklists() {}

}
