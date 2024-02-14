import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:icet/provider/overviewboardProvider.dart';

import '../datamodel/boards.dart';

class OverviewboardController extends GetxController {
  late OverviewboardProvider overviewboardProvider;

  final selected = "1".obs;

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
    overviewboardProvider = OverviewboardProvider();
  }

  Future<Boards?> fetchBoard() async {
    Response response = await overviewboardProvider.getBoard();
    print("Controller : ${response.body}");
    Boards responseBoards = Boards.fromJson(response.body[0]);
    return responseBoards;
  }

  void createBoard() {}

  void fetchAssest() {}

  void createAssest() {}

  // Sample API request needs to be removed

  // Future<Boards?> getApi() async {
  //   Boards? model;
  //   try {
  //     http.Response response =
  //         await http.get(Uri.http('127.0.0.1:8000', 'api/boards'), headers: {
  //       'Authorization': 'Token 3372bd9880a5644b51b5f008b39adef82b524973',
  //       "Access-Control-Allow-Origin": "*",
  //       'Content-Type': 'application/json',
  //       "User-Agent": "chrome",
  //       'accept': 'application/json'
  //     });
  //     if (response.statusCode == 200) {
  //       ///data successfully
  //
  //       var result = jsonDecode(response.body);
  //
  //       print(result);
  //       model = Boards.fromJson(result[0]);
  //
  //       return model;
  //     } else {
  //       ///error
  //       return model;
  //     }
  //   } catch (e) {
  //     log('Error while getting data is $e');
  //     print('Error while getting data is $e');
  //   } finally {}
  // }
}
