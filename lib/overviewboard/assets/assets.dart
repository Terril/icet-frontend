import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icet/const/colors.dart';
import 'package:icet/extension/ext.dart';

import '../../logs.dart';
import 'assets_controller.dart';

class AssetsView extends GetView<AssetsController> {
  AssetsView(this.boardId, {super.key});

  final String? boardId;

  void _saveButtonClicked() {
    controller.createAssets(filterNull(boardId));
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
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          Logger.printLog(message: "Get Back called  ${controller.assetsCreated}");
                          Get.back(result: controller.assetsCreated);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: Get.width / 7,
                              child: TextField(
                                maxLength: 100,
                                controller: controller.textController,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  border: InputBorder.none,
                                  suffixIcon:
                                      Icon(Icons.drive_file_rename_outline),
                                  label: Text('New Asset',
                                      style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600)),
                                ),
                                style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600),
                              )),
                          IconButton(
                            color: Colors.red,
                            icon: const Icon(Icons.delete_outlined),
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ]),
                    const SizedBox(height: 24),
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
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              right: 20.0,
                                              left: 16.0,
                                              bottom: 16),
                                          child: Row(children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // <-- Radius
                                                    ),
                                                    backgroundColor:
                                                        colorBlueButton),
                                                onPressed: () {
                                                  _saveButtonClicked();
                                                },
                                                child: const Text("Save",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colorWhite))),
                                            const SizedBox(width: 12),
                                            OutlinedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8), // <-- Radius
                                                  ),
                                                ),
                                                onPressed: () {
                                                  controller.quillController.clear();
                                                },
                                                child: const Text("Clear",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            colorButtonGrey))),
                                          ]),
                                        )))
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Center(child: emptyView(context));
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return Center(child: emptyView(context));
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(children: [
                                      ListTile(
                                        title: Text(
                                          filterNull(
                                                  snapshot.data?[index]?.name)
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
