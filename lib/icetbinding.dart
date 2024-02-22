import 'package:get/get.dart';
import 'package:icet/provider/apiServiceProvider.dart';
import 'package:icet/signupsignin/signup_controller.dart';
import 'overviewboard/overviewboard_controller.dart';

class IceTBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OverviewboardController());
    Get.lazyPut(() => SignupController());
    Get.put(APIServiceProvider());

  }
}