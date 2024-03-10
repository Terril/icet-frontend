import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icet/const/colors.dart';

import '../overviewboard_controller.dart';

class AssetsView extends GetView<OverviewboardController> {
  AssetsView({super.key});

  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Flexible(
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
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'New Asset',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.w600),
                        ),
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
                      child: Container(
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
                                                      iconTheme: QuillIconTheme(
                                        iconButtonSelectedData: IconButtonData(
                                            highlightColor: colorBlue),
                                        iconButtonSelectedStyle: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    colorBlue)),
                                      ))),
                                      dialogTheme: const QuillDialogTheme(
                                          buttonStyle: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(colorBlue)),
                                          dialogBackgroundColor:
                                              colorGreyEditor),
                                      toolbarIconAlignment: WrapAlignment.start,
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
                                      controller: _controller,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: QuillEditor.basic(
                                    configurations: QuillEditorConfigurations(
                                      padding: EdgeInsets.all(5),
                                      controller: _controller,
                                      readOnly: false,
                                      sharedConfigurations:
                                          const QuillSharedConfigurations(
                                        locale: Locale('en'),
                                      ),
                                    ),
                                  ),
                                )
                              ]))),
                ]))),
      ),
    );
  }
}
