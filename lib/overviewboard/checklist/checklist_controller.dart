import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/logs.dart';
import 'package:icet/provider/apiServiceProvider.dart';

import '../../datamodel/columns.dart';

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
          (quillController.plainTextEditingValue.text.length <= 30000 &&
                  quillController.plainTextEditingValue.text.isNotEmpty)
              ? true
              : false;
      _showSaveAndCancelButtons(state);
    });
  }

  void _showSaveAndCancelButtons(bool state) {
    enableButtons.value = state;
  }


  Future<bool> updateChecklist(String assetId) async {
    Map<String, dynamic> map = HashMap();
    map["name"] = textController.text;
    map["md_content"] = quillController.document.toDelta().toJson();
    Response response = await provider.updateRows(assetId, map);

    if(response != null && response.isOk) {
      assetsCreated = true;
    }
    Logger.printLog(message: "${response.bodyString}");

    return assetsCreated;
  }


  Future<bool> deleteChecklist(String columnId) async {
    Response response = await provider.deleteColumn(columnId);
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
