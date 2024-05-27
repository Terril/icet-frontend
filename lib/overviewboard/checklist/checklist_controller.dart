import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/logs.dart';
import 'package:icet/provider/apiServiceProvider.dart';

import '../../datamodel/cell.dart';


class ChecklistController extends GetxController with CacheManager {
  late APIServiceProvider provider;

  final QuillController quillController = QuillController.basic();
  TextEditingController textController = TextEditingController();

  RxBool enableButtons = false.obs;

  bool assetsCreated = false;

  @override
  void onInit() {
    super.onInit();
    provider = APIServiceProvider();

    quillController.addListener(() {
      bool state =
          (quillController.plainTextEditingValue.text.length >= 30000 &&
                  quillController.plainTextEditingValue.text.isNotEmpty)
              ? true
              : false;
      _showSaveAndCancelButtons(state);
    });
  }

  void _showSaveAndCancelButtons(bool state) {
    enableButtons.value = state;
  }

  // Future<bool> createChecklist(String boardId) async {
  //   if(textController.text.length >= 50) {
  //   //  showErrorMessage.value = true;
  //     return false;
  //   } else if (quillController.plainTextEditingValue.text.length >= 30000) {
  //     _showSaveAndCancelButtons(true);
  //   }
  //
  //   Map<String, dynamic> map = HashMap();
  //   map["name"] = textController.text;
  //   map["content"] = {"data": quillController.document.toDelta().toJson()};
  //   map["board"] = boardId;
  //   map["interest_level"] =
  // selected.value == "Unset" ? 1 : int.parse(selected.value);
  //  Response response = await provider.addRows(map);
  //
  //  if (response != null && response.isOk) {
  //    Logger.printLog(message: "This is create Assets");
  //    assetsCreated = true;
  //  }
  //  Logger.printLog(message: "${response.bodyString}");

  //   return assetsCreated;
  // }

  Future<bool> updateChecklist(String columnId) async {
    Map<String, dynamic> map = HashMap();
    map["name"] = textController.text;
    map["data_type"] = {"rating": "2"};
    map["description_data"] = {"data": quillController.document.toDelta().toJson()};
    Response response = await provider.updateColumns(columnId, map);

    if (response != null && response.isOk) {
      assetsCreated = true;
    }
    Logger.printLog(message: "${response.bodyString}");

    return assetsCreated;
  }

  Future<String?> getCell(String columnId, String rowId) async {
    Response response = await provider.getCell(rowId, columnId);
    Logger.printLog(message: "${response.bodyString}");
    var cell = Cells.fromJson(response.body);

    return cell.id;
  }

  Future<bool> updateCell(String cellData, String cellId) async {
    Map<String, dynamic> map = HashMap();
    map["data"] = cellData;
    map["content_str"] = "empty";
    Response response = await provider.updateCell(cellId, map);

    if (response != null && response.isOk) {
      assetsCreated = true;
    }
    Logger.printLog(message: "${response.bodyString}");

    return assetsCreated;
  }

  Future<bool> deleteChecklist(String columnId) async {
    Response response = await provider.deleteColumn(columnId);
    Logger.printLog(message: "${response.bodyString}");
    if (response != null && response.isOk) {
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