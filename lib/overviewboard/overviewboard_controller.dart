
import 'dart:collection';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/logs.dart';
import 'package:icet/provider/apiServiceProvider.dart';

import '../datamodel/boards.dart';
import '../datamodel/columns.dart';

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
    loadBoard();
  }

  void selectDrawer(int position) {
    obxPosition.value = position;
  }

  void setSelected(String value) {
    selected.value = value;
  }

  Future<List<Boards?>> _fetchBoard() async {
    Response response = await overviewboardProvider.getBoard();
    List<Boards> responseBoards = BoardList.fromJsonToList(response.body).list;

    Logger.printLog(message: "${response.bodyString}");
    return responseBoards;
  }

  void loadBoard() {
    futureBoard = _fetchBoard();
    update();
  }

  void callCustomBoard() async {
    Response response = await overviewboardProvider.getApiBoardsCustom();
    Logger.printLog(message: "${response.bodyString}");
    if (response != null && response.isOk) {
      loadBoard();
    }

    Boards responseBoards = Boards.fromJson(response.body);
  }

  Future<Columns> addColumns(String boardId, String title, String desc) async {
    Map<String, String> map = HashMap();
    map["name"] = title;
    map["board"] = boardId;
    map["description"] = desc;
    Response response = await overviewboardProvider.addColumn(map);

    var responseBody = Columns.fromJson(response.body);
    return responseBody;
  }

  int? getItemCount(int?  itemCount) {
   if(itemCount == null) return 1;

   if(itemCount > 0) { return itemCount + 1 ; }
  }

}
