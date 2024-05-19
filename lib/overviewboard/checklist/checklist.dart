
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
  const ChecklistView(this.column, this.asset, this.isDeletable, {super.key});

  final Columns? column;
  final Rows? asset;
  final bool isDeletable;

  Future<bool> _saveButtonClicked() {
    return controller.updateChecklist(filterNull(column?.id));
  }

  Future<bool> _deleteChecklist() {
    return controller.deleteChecklist(filterNull(column?.id));
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
    title = "$title \u{203A}";
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                                            color: colorBlueButton,
                                            fontSize: 12)),
                                    onPressed: () {
                                      _saveButtonClicked().then(
                                          (value) => Get.back(result: value));
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
                                      Get.back(
                                          result: controller.assetsCreated);
                                    },
                                  ),
                                ])),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: Get.width / 7,
                                  child: Text(title,
                                      style: const TextStyle(
                                          color: colorTextUnsetButton,
                                          fontSize: 16))),
                              Visibility(
                                  visible: isDeletable,
                                  child: IconButton(
                                    color: Colors.red,
                                    icon: const Icon(Icons.delete_outlined),
                                    onPressed: () {
                                      //_showDeleteDialog(context);
                                      UIUtils.showDeleteDialog(
                                          context,
                                          "Are you sure you want to delete this\n checklist? \n"
                                          "All notes and criteria will be deleted and \ncannot be retrieved.",
                                          onCloseClicked: () {
                                        Get.back(closeOverlays: true);
                                      }, onDeleteClicked: () {
                                        _deleteChecklist().then((value) =>
                                            Get.back(closeOverlays: true));
                                      });
                                    },
                                  ))
                            ]),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  textAlign: TextAlign.start,
                                  filterNull(column?.name),
                                  style: const TextStyle(
                                      color: colorGrey, fontSize: 16),
                                )
                              ],
                            )),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colorGreyField)),
                          child: Wrap(
                            children: [
                              ButtonTheme(
                                  minWidth: 40.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor:
                                          colorCheckMark, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                    child: const Icon(Icons.check,
                                        color: Colors.white),
                                  )),
                              ButtonTheme(
                                  minWidth: 40.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor: colorClearButton,
                                      // <-- Button color
                                      foregroundColor:
                                          Colors.blue, // <-- Splash color
                                    ),
                                    child: const Icon(Icons.clear,
                                        color: Colors.white),
                                  )),
                              ButtonTheme(
                                  minWidth: 40.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor: colorQuestionButton,
                                      // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                    child: const Icon(Icons.question_mark_outlined,
                                        color: Colors.white),
                                  )),
                              ButtonTheme(
                                  minWidth: 40.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor:
                                      colorEmojiButton, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                    child: const Icon(Icons.emoji_emotions_outlined,
                                        color: Colors.white),
                                  )),
                              ButtonTheme(
                                  minWidth: 40.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor:
                                      colorGreyField, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                    child: null,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                            height: Get.height / 1.75,
                            child: Stack(children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: colorGreyField)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                        highlightColor:
                                                            colorBlue),
                                                iconButtonSelectedStyle:
                                                    ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll<
                                                                    Color>(
                                                                colorBlue)),
                                              ))),
                                              dialogTheme: const QuillDialogTheme(
                                                  buttonStyle: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll<
                                                                  Color>(
                                                              colorBlue)),
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
                                          visible:
                                          controller.enableButtons.value,
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  right: 20.0,
                                                  left: 16.0,
                                                  bottom: 16),
                                              child: const Text(
                                                  "Max. character limit is 30000",
                                                  style: TextStyle(
                                                      backgroundColor:
                                                      colorDeleteButton,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: colorWhite))),
                                        ))
                                      ])),
                            ])),
                        const SizedBox(height: 24),
                      ]))),
        )
      ]),
    );
  }
}
