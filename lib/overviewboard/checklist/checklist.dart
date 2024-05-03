import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icet/const/colors.dart';
import 'package:icet/datamodel/columns.dart';
import 'package:icet/datamodel/rows.dart';
import 'package:icet/extension/ext.dart';
import 'package:icet/utils.dart';

import '../../logs.dart';
import 'checklist_controller.dart';

class ChecklistView extends GetView<ChecklistController> {
  ChecklistView(this.column, this.asset, this.isDeletable, {super.key});

  final Columns? column;
  final Rows? asset;
  final bool isDeletable;

  // Future<bool> _saveButtonClicked() {
  //   return asset?.id != null
  //       ? controller.updateAssets(filterNull(asset?.id))
  //       : controller.createAssets(filterNull(boardId));
  // }

  Future<bool> _deleteAsset() {
    return controller.deleteAsset(filterNull(asset?.id));
  }

  Widget emptyView(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty_note.png"),
        const SizedBox(height: 10),
        const Text("Your column is empty",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400)),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    String title = asset != null ? filterNull(asset?.name) : 'New Asset';
    String description = asset != null
        ? filterNull(asset?.mdContent)
            .replaceAll("\n", "\\n")
            .replaceAll("\"", "\\\"")
        : '';
    if (description.isNotEmpty) {
      controller.quillController.document = Document.fromHtml(description);
    }
    controller.textController.text = title;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Flex(direction: Axis.horizontal, children: [
        Flexible(
          child: FractionallySizedBox(
              alignment: FractionalOffset.topRight,
              widthFactor: 0.5,
              child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(children: <Widget>[
                    ButtonTheme(
                        layoutBehavior: ButtonBarLayoutBehavior.constrained,
                        child: ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton.icon(
                                icon: const Icon(Icons.check,
                                    color: colorBlueButton),
                                label: const Text("Save",
                                    style: TextStyle(
                                        color: colorBlueButton, fontSize: 12)),
                                onPressed: () {
                                  // _saveButtonClicked()
                                  //     .then((value) => Get.back(result: value));
                                },
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.clear),
                                label: const Text(
                                  "Close",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () {
                                  Logger.printLog(
                                      message:
                                          "Get Back called  ${controller.assetsCreated}");
                                  Get.back(result: controller.assetsCreated);
                                },
                              ),
                            ])),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: Get.width / 7,
                              child: TextField(
                                controller: controller.textController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  border: InputBorder.none,
                                  counterText: "",
                                  suffixIcon: const Icon(
                                      Icons.drive_file_rename_outline),
                                  label: Text(title,
                                      style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600)),
                                ),
                                style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600),
                              )),
                          Visibility(
                              visible: isDeletable,
                              child: IconButton(
                                color: Colors.red,
                                icon: const Icon(Icons.delete_outlined),
                                onPressed: () {
                                  //_showDeleteDialog(context);
                                  UIUtils.showDeleteDialog(
                                      context,
                                      "Are you sure you want to delete this\n asset? \n"
                                          "All notes and criteria will be deleted and \ncannot be retrieved.",
                                      onCloseClicked: () {
                                        Get.back(closeOverlays: true);
                                      }, onDeleteClicked: () {
                                    _deleteAsset().then((value) =>
                                        Get.back(closeOverlays: true));
                                  });
                                },
                              ))
                        ]),
                    const SizedBox(height: 16),
                    SizedBox(
                        height: Get.height / 1.75,
                        child: Stack(children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: colorGreyField)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: colorGreyEditor,
                                      width: Get.width,
                                      child: QuillToolbar.simple(
                                        configurations:
                                            QuillSimpleToolbarConfigurations(
                                          buttonOptions:
                                              const QuillSimpleToolbarButtonOptions(
                                                  base:
                                                      QuillToolbarBaseButtonOptions(
                                                          iconTheme:
                                                              QuillIconTheme(
                                            iconButtonSelectedData:
                                                IconButtonData(
                                                    highlightColor: colorBlue),
                                            iconButtonSelectedStyle: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll<
                                                        Color>(colorBlue)),
                                          ))),
                                          dialogTheme: const QuillDialogTheme(
                                              buttonStyle: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll<
                                                          Color>(colorBlue)),
                                              dialogBackgroundColor:
                                                  colorGreyEditor),
                                          toolbarIconAlignment:
                                              WrapAlignment.start,
                                          toolbarIconCrossAlignment:
                                              WrapCrossAlignment.start,
                                          showDividers: true,
                                          showColorButton: false,
                                          showFontFamily: false,
                                          showFontSize: false,
                                          showStrikeThrough: false,
                                          showInlineCode: false,
                                          showSubscript: false,
                                          showSuperscript: false,
                                          showBackgroundColorButton: false,
                                          showClearFormat: false,
                                          showCodeBlock: false,
                                          showQuote: false,
                                          showIndent: false,
                                          showUndo: false,
                                          showRedo: false,
                                          showSearchButton: false,
                                          sectionDividerColor: Colors.black,
                                          controller:
                                              controller.quillController,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: QuillEditor.basic(
                                        configurations:
                                            QuillEditorConfigurations(
                                          padding: const EdgeInsets.all(5),
                                          controller:
                                              controller.quillController,
                                          readOnly: false,
                                          sharedConfigurations:
                                              const QuillSharedConfigurations(
                                            locale: Locale('en'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(() => Visibility(
                                        visible: controller.enableButtons.value,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              right: 20.0,
                                              left: 16.0,
                                              bottom: 16),
                                          child: OutlinedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8), // <-- Radius
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.quillController
                                                    .clear();
                                              },
                                              child: const Text("Clear",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: colorButtonGrey))),
                                        )))
                                  ])),
                        ])),
                    const SizedBox(height: 24),
                  ]))),
        )
      ]),
    );
  }
}
