import 'package:get/get.dart';
import 'overviewboard/overviewboard_controller.dart';

class IceTBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OverviewboardController());
  }
}