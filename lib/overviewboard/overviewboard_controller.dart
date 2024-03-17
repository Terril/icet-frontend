
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/provider/apiServiceProvider.dart';

import '../cache/cachemanager.dart';
import '../datamodel/boards.dart';

class OverviewboardController extends GetxController {
  late APIServiceProvider overviewboardProvider;

  final selected = "1".obs;

  RxInt obxPosition = 0.obs;

  void selectDrawer(int position) {
    obxPosition.value = position;
  }

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

  void setSelected(String value) {
    selected.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    overviewboardProvider = APIServiceProvider();
  }

  Future<List<Boards?>> fetchBoard() async {
    Response response = await overviewboardProvider.getBoard();

    List<Boards> responseBoards = BoardList.fromJsonToList(response.body).list;
    return responseBoards;
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
