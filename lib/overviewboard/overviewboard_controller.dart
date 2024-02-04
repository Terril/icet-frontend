
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/provider/overviewboardProvider.dart';

class OverviewboardController extends GetxController {

  late OverviewboardProvider overviewboardProvider ;
  @override
  void onInit() {
    overviewboardProvider = OverviewboardProvider();
    super.onInit();
  }

  Future<Response> fetchBoard() async {
    return overviewboardProvider.getBoard();
  }

  void createBoard() {

  }

  void fetchAssest() {}

  void createAssest() {}
}
