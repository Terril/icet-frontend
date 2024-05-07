import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/logs.dart';
import 'package:icet/provider/apiServiceProvider.dart';

import '../../datamodel/columns.dart';

class AssetsController extends GetxController with CacheManager {
  late APIServiceProvider provider;

  final QuillController quillController = QuillController.basic();
  TextEditingController textController = TextEditingController();

  RxBool enableButtons = false.obs;

  bool assetsCreated = false;

  List<String> get dropdownItems {
    List<String> menuItems = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10"
    ];
    return menuItems;
  }

  final selected = "Unset".obs;

  @override
  void onInit() {
    super.onInit();
    provider = APIServiceProvider();

    quillController.addListener(() {
      bool state =
          (quillController.plainTextEditingValue.text.length <= 30000 &&
                  quillController.plainTextEditingValue.text.isNotEmpty)
              ? true
              : false;
      _showSaveAndCancelButtons(state);
    });
  }

  void setSelected(String value) {
    selected.value = value;
  }

  void _showSaveAndCancelButtons(bool state) {
    enableButtons.value = state;
  }

  Future<List<Columns?>> fetchColumns(String? boardId) async {
    Response response = await provider.getColumnsByBoardId(boardId);
    List<Columns> responseBoards =
        ColumnList.fromJsonToList(response.body).list;

    return responseBoards;
  }

  Future<bool> createAssets(String boardId) async {
    Map<String, dynamic> map = HashMap();
    map["name"] = textController.text;
    map["content"] = {"data" : quillController.document.toDelta().toJson()};
    map["board"] = boardId;
    map["interest_level"] = int.parse(selected.value);
    Response response = await provider.addRows(map);

    if(response != null && response.isOk) {
      Logger.printLog(message: "This is create Assets");
      assetsCreated = true;
    }
    Logger.printLog(message: "${response.bodyString}");

    return assetsCreated;
  }

  Future<bool> updateAssets(String assetId) async {
    Map<String, dynamic> map = HashMap();
    map["name"] = textController.text;
    map["content"] = {"data" : quillController.document.toDelta().toJson()};
    map["interest_level"] = int.parse(selected.value);
    Response response = await provider.updateRows(assetId, map);

    if(response != null && response.isOk) {
      assetsCreated = true;
    }
    Logger.printLog(message: "${response.bodyString}");

    return assetsCreated;
  }


  Future<bool> deleteAsset(String rowId) async {
    Response response = await provider.deleteRow(rowId);
    Logger.printLog(message: "${response.bodyString}");
    if(response != null && response.isOk) {
      Logger.printLog(message: "This is create Assets");
      assetsCreated = true;
    }

    return assetsCreated;
  }

  @override
  void dispose() {
    quillController.dispose();
    textController.dispose();
    super.dispose();
  }
}
