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
import '../../ratings.dart';
import 'checklist_controller.dart';

class ChecklistView extends GetView<ChecklistController> {
  ChecklistView(this.column, this.asset, this.isDeletable,
      {super.key});

  final Columns? column;
  final Rows? asset;
  final bool isDeletable;
  late String cellId;
  late String cellData = "";

  Future<bool> _saveButtonClicked() {
    return controller.updateChecklist(filterNull(column?.id)).then((value) => _updateCell(cellData));
  }

  Future<bool> _updateCell(String cellData) {
    return controller.updateCell(cellData, cellId);
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

    controller
        .getCell(filterNull(column?.id), filterNull(asset?.id))
        .then((value) => cellId = filterNull(value));

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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colorGreyField)),
                          child: Wrap(
                            children: [
                              ButtonTheme(
                                  minWidth: 32.0,
                                  height: 32.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cellData = (Rating.pass.name);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            );
                                          } else {
                                            return const CircleBorder();
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      side: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const BorderSide(
                                              color: Colors.blue,
                                              width: 1,
                                            );
                                          } else {
                                            return null;
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(5)), // <-- Splash color
                                    ),
                                    child: Image.asset('assets/images/ok_icon.png'),
                                  )),
                              ButtonTheme(
                                  minWidth: 32.0,
                                  height: 32.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cellData = (Rating.fail.name);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            );
                                          } else {
                                            return const CircleBorder();
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      side: MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const BorderSide(
                                              color: Colors.blue,
                                              width: 1,
                                            );
                                          } else {
                                            return null;
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(5)),
                                    ),
                                      child: Image.asset('assets/images/failure_icon.png'),
                                  )),
                              ButtonTheme(
                                  minWidth: 32.0,
                                  height: 32.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cellData = (Rating.unsure.name);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            );
                                          } else {
                                            return const CircleBorder();
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      side: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const BorderSide(
                                              color: Colors.blue,
                                              width: 1,
                                            );
                                          } else {
                                            return null;
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(5)), // <-- Splash color
                                    ),
                                      child: Image.asset('assets/images/doubtful_icon.png'),
                                  )),
                              ButtonTheme(
                                  minWidth: 32.0,
                                  height: 32.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cellData = (Rating.mediocre.name);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            );
                                          } else {
                                            return const CircleBorder();
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      side: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const BorderSide(
                                              color: Colors.blue,
                                              width: 1,
                                            );
                                          } else {
                                            return null;
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(5)), // <-- Splash color
                                    ),
                                    child: Image.asset('assets/images/annoyed_icon.png'),
                                  )),
                              ButtonTheme(
                                  minWidth: 32.0,
                                  height: 32.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cellData = (Rating.na.name);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            );
                                          } else {
                                            return const CircleBorder();
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      side: MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const BorderSide(
                                              color: Colors.blue,
                                              width: 1,
                                            );
                                          } else {
                                            return null;
                                          }
                                          // Defer to the widget's default.
                                        },
                                      ),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(5)),// <-- Splash color
                                    ),
                                      child: Image.asset('assets/images/clueless_icon.png'),
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
                                              visible: controller
                                                  .enableButtons.value,
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      const EdgeInsets.only(
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
