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
      _showSaveAnnCancelButtons(state);
    });
  }

  void _showSaveAnnCancelButtons(bool state) {
    enableButtons.value = state;
  }

  Future<List<Columns?>> fetchColumns(String? boardId) async {
    Response response = await provider.getColumnsByBoardId(boardId);
    List<Columns> responseBoards =
        ColumnList.fromJsonToList(response.body).list;

    return responseBoards;
  }

  void createAssets(String boardId) async {
    Map<String, String> map = HashMap();
    map["name"] = textController.text;
    map["md_content"] = quillController.plainTextEditingValue.text;
    map["board"] = boardId;
    Response response = await provider.addRows(map);

    Logger.printLog(message: "${response.bodyString}");
  }

  @override
  void onClose() {
    super.onClose();
    quillController.dispose();
  }
}
