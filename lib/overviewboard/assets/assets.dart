import 'dart:convert';

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
import 'package:icet/overviewboard/checklist/checklist.dart';
import 'package:icet/utils.dart';

import 'assets_controller.dart';

class AssetsView extends GetView<AssetsController> {
  AssetsView(this.boardId, this.asset, this.isDeletable, {super.key});

  final String? boardId;
  final Rows? asset;
  final bool isDeletable;

  Future<bool> _saveButtonClicked() {
    return asset?.id != null
        ? controller.updateAssets(filterNull(asset?.id))
        : controller.createAssets(filterNull(boardId));
  }

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

  showInterestLevel() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(4.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // <-- Radius
              ),
              backgroundColor: colorGreyEditor),
          onPressed: null,
          icon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Obx(
                () => Text(controller.selected.value,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: colorTextUnsetButton)),
              )),
          label: const Icon(Icons.arrow_drop_down),
        ),
        items: [
          ...controller.dropdownItems.map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          ),
        ],
        onChanged: (value) {
          controller.setSelected(value!);
        },
      ),
    );
  }

  void showChecklist(
      BuildContext context, Columns? columns, Rows? asset, bool canDelete) {
    showGeneralDialog<bool>(
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0.5, 0))
              .animate(a1),
          child: widget,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return ChecklistView(columns, asset, canDelete);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = asset != null ? filterNull(asset?.name) : 'New Asset';

    if (asset != null && filterNullList(asset?.content?.data).isNotEmpty) {
      controller.quillController.document =
          Document.fromJson(asset!.content!.data as List<dynamic>);
    }
    controller.textController.text = title;
    if (asset != null && asset?.interestLevel != null) {
      controller.setSelected(asset!.interestLevel.toString());
    }

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
                                  _saveButtonClicked()
                                      .then((value) => Get.back(result: value));
                                },
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.clear),
                                label: const Text(
                                  "Close",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () {
                                  Get.back(result: controller.assetsCreated);
                                },
                              ),
                            ])),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: Get.width / 7,
                              child: Obx(() => TextField(
                                    maxLength: 51,
                                    autofocus: true,
                                    controller: controller.textController,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: InputBorder.none,
                                      counterText: "",
                                      errorText:
                                          controller.showErrorMessage.value
                                              ? "Max. character limit is 50"
                                              : "",
                                      suffix: const Icon(
                                          Icons.drive_file_rename_outline),
                                      label: Text(title,
                                          style: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600),
                                  ))),
                          Row(
                            children: [
                              const Text("Interest Level: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                              showInterestLevel(),
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
                                        _deleteAsset().then((value) {
                                          Get.back(closeOverlays: true);
                                          Get.back(
                                              result: controller.assetsCreated);
                                        });
                                      });
                                    },
                                  ))
                            ],
                          )
                        ]),
                    const SizedBox(height: 16),
                    SizedBox(
                        height: Get.height / 2.75,
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Checklists',
                            style: TextStyle(
                              height: 1.5,
                              shadows: [
                                Shadow(
                                    color: colorBlueText,
                                    offset: Offset(0, -10))
                              ],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: colorBlueText,
                            ),
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.add_sharp),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                            ),
                            onPressed: () => {},
                            label: const Text("New checklist"),
                          )
                        ]),
                    Expanded(
                        child: FutureBuilder(
                      future: controller.fetchColumns(boardId),
                      builder: (context, snapshot) {
                        List<Columns?>? updatedList = snapshot.data?.sublist(1);
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (snapshot.hasError) {
                            return Center(child: emptyView(context));
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return Center(child: emptyView(context));
                            } else {
                              return ListView.builder(
                                  itemCount: updatedList?.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(children: [
                                      ListTile(
                                        onTap: () {
                                          showChecklist(context,
                                              updatedList?[index], asset, true);
                                        },
                                        title: Text(
                                          filterNull(updatedList?[index]?.name)
                                              .toUpperCase(),
                                        ),
                                        trailing: const Icon(Icons.check_circle,
                                            color: colorCheckMark),
                                      ),
                                      const Divider(
                                        color: colorGreyField,
                                      )
                                    ]);
                                  });
                            }
                          }
                        }
                      },
                    )),
                  ]))),
        )
      ]),
    );
  }
}
