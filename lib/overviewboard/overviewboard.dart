import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:icet/extension/ext.dart';
import 'package:icet/logs.dart';
import 'package:icet/utils.dart';

import '../const/colors.dart';
import '../datamodel/boards.dart';
import '../datamodel/columns.dart';
import '../datamodel/rows.dart';
import '../ratings.dart';
import 'assets/assets.dart';
import 'overviewboard_controller.dart';
import 'overviewboard_dialog.dart';

class OverviewboardView extends GetView<OverviewboardController>
    with OverviewboardDialogView {
  OverviewboardView({super.key});

  String selectedValue = "1";

  List<Rows> itemRowWidget = <Rows>[];
  List<Columns> itemColumnWidget = <Columns>[];

  Boards? board = null;
  List<String> list = <String>['New asset', 'New checklist'];
  double widthSize = (Get.width / 6);

  void showAssets(
      BuildContext context, String? boardId, Rows? asset, bool canDelete) {
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
        return AssetsView(boardId, asset, canDelete);
      },
    ).then((value) => filterBoolNull(value) ? controller.loadBoard() : null);
  }

  List<Widget> _getTitleWidget(BuildContext context, List<Columns> items) {
    double widthSize =
        (Get.width / (items.length + 2)); // Earlier items.length + 2
    List<Widget> widget = <Widget>[];
    widget.add(_columWidgetWithoutDropDown(Columns(name: 'ASSET'), widthSize));
    widget.add(_columWidgetWithoutDropDown(items[0], widthSize));
    List<Columns> updatedItem = items.sublist(1);
    for (var element in updatedItem) {
      widget.add(_getTitleItemWidget(context, element, widthSize));
    }
    return widget;
  }

  Widget _getTitleItemWidget(BuildContext context, Columns col, double width) {
    return _addColumnDropDown(context, col, width);
  }

  Widget _columWidgetWithoutDropDown(Columns column, double width) {
    return Container(
      color: const Color.fromARGB(249, 250, 251, 255),
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(filterNull(column.name?.toUpperCase()),
          maxLines: 2, textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: InkWell(
          onTap: () {
            showAssets(context, board?.id, itemRowWidget[index], true);
          },
          child: Text(filterNull(itemRowWidget[index].name))),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    List<Widget> widget = <Widget>[];
    double widthSize = (Get.width /
        (itemColumnWidget.length + 2)); // Earlier itemColumnWidget.length + 2
    for (int j = 0; j < itemColumnWidget.length; j++) {
      if (j == 0) {
        Widget sectionOne = Container(
            width: widthSize,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: Text(
                itemRowWidget[controller.rowZeroIndex].interestLevel.toString())
            // Obx(() => DropdownButton(
            //       underline: const SizedBox(),
            //       iconSize: 0.0,
            //       onChanged: (newValue) {
            //         controller.setSelected(newValue!);
            //       },
            //       value: controller.selected.value,
            //       items: controller.dropdownItems.map((selectedType) {
            //         return DropdownMenuItem(
            //           value: selectedType,
            //           child: Text(
            //             selectedType,
            //           ),
            //         );
            //       }).toList(),
            //     )), //([index]),
            );
        widget.add(sectionOne);
        while (controller.rowZeroIndex <= itemRowWidget.length) {
          controller.rowZeroIndex++;
          break;
        }
      } else {
        Widget iconData;
        if(filterNull(itemColumnWidget[j].cells![index].data).isEmpty) {
          iconData = const Icon(Icons.check_circle, color: colorCheckMark);
        } else {
          Rating rate = Rating.values.byName(
              filterNull(itemColumnWidget[j].cells![index].data));
          iconData = switch (rate) {
            Rating.great =>
                ButtonTheme(
                    minWidth: 24.0,
                    height: 24.0,
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
            Rating.failure =>
                ButtonTheme(
                    minWidth: 24.0,
                    height: 24.0,
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
            Rating.doubtful =>
                ButtonTheme(
                    minWidth: 24.0,
                    height: 24.0,
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
            Rating.happy =>
                ButtonTheme(
                    minWidth: 24.0,
                    height: 24.0,
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
            Rating.clueless =>
                ButtonTheme(
                    minWidth: 24.0,
                    height: 24.0,
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
            _ => const Icon(Icons.check_circle, color: colorCheckMark),
          };
        }
        Widget sectionOthers = Container(
          width: widthSize,
          height: 52,
          padding: const EdgeInsets.all(13),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              iconData
            ],
          ),
        );
        widget.add(sectionOthers);
      }
    }

    return Row(children: widget);
  }

  Widget _addDropDown(BuildContext context, String? boardId) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),

        // dropdown below..
        child: DropdownButton<String>(
          hint: const Text("Add"),
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          underline: Container(
            height: 2,
          ),
          onChanged: (String? value) {
            if (value == list.first) {
              showAssets(context, boardId, null, false);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => newChecklistDialog(
                          onTapCreate: (String title, String desc) {
                        controller
                            .addColumns(filterNull(boardId), title, desc)
                            .then((value) =>
                                value ? controller.loadBoard() : null);
                      }));
            }
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
              onTap: () {},
            );
          }).toList(),
        ));
  }

  Widget _addColumnDropDown(
      BuildContext context, Columns column, double width) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
          color: const Color.fromARGB(249, 250, 251, 255),
          width: width,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(filterNull(column.name?.toUpperCase()),
              maxLines: 2, textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        items: [
          ..._MenuItems.firstItems.map(
            (item) => DropdownMenuItem<_MenuItem>(
              value: item,
              child: _MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          if (value?.text == _MenuItems.delete.text) {
            UIUtils.showDeleteDialog(
                context,
                "Are you sure you want to delete this checklist? \n"
                "All notes within will be deleted and cannot be \nretrieved.",
                onCloseClicked: () {
              Get.back(closeOverlays: true);
            }, onDeleteClicked: () {
              controller.deleteColumn(filterNull(column.id)).then((value) => {
                    value ? controller.loadBoard() : null,
                    Get.back(closeOverlays: true)
                  });
            });
          }
          _MenuItems.onChanged(context, value!);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }

  Widget _addProfile() {
    String email = controller.getUserEmail();

    final List<_MenuItem> profileValues = [
      _MenuItem(text: email, icon: null, color: colorGrey),
      const _MenuItem(
          text: 'Sign Out',
          icon: Icons.exit_to_app_outlined,
          color: colorDeleteButton),
    ];
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://source.unsplash.com/50x50/?portrait',
              scale: 1.0),
        ),
        items: profileValues
            .map((item) => DropdownMenuItem<_MenuItem>(
                  value: item,
                  child: _MenuItems.buildItem(item),
                ))
            .toList(),
        onChanged: (value) {
          if (value?.icon != null) {
            Get.offAllNamed('/signin');
          }
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }

  Dialog showRenameDialog(String title, {required Function onTapCreate}) {
    final titleEditor = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
          height: Get.width / 4.5,
          width: Get.height / 1.7,
          margin:
              const EdgeInsets.only(top: 20, left: 32, right: 32, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      Get.back();
                    },
                  )),
              const SizedBox(height: 20.0),
              const Text(
                'Rename board',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Board’s name',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: titleEditor,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: colorGreyField),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: title),
                  )),
              const SizedBox(height: 16.0),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                        backgroundColor: colorBlueButton),
                    onPressed: () {
                      onTapCreate(titleEditor.text);
                      Get.back(closeOverlays: true);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Save',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: colorWhite)),
                    )),
              )
            ],
          )),
    );
  }

  Widget emptyView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty_note.png"),
        const SizedBox(height: 10),
        const Text("Your board is empty",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
        const Text("Click Add board to create a new one",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          icon: const Icon(Icons.add_sharp),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
          ),
          onPressed: () => {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    newBoardDialog(onTapBoardSelection: (SelectedBoard board) {
                      switch (board) {
                        case SelectedBoard.STOCK:
                          break;
                        case SelectedBoard.CUSTOM:
                          {
                            controller.callCustomBoard();
                            break;
                          }
                      }
                    }))
          },
          label: const Text("Add board"),
        )
      ],
    );
  }

  Widget _widgetOptions(BuildContext context, Boards? data) {
    String? title = data?.name;
    itemRowWidget = filterNullList(data?.rows);
    itemColumnWidget = filterNullList(data?.columns);
    board = data;
    return Container(
        color: colorBlue,
        margin: const EdgeInsets.only(
          left: 24,
          top: 0,
          right: 0,
          bottom: 0,
        ),
        padding: const EdgeInsets.only(
          left: 24,
          top: 24,
          right: 24,
          bottom: 24,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                filterNull(title),
                style: const TextStyle(
                    fontSize: 21.0, fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 12.5),
              IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => showRenameDialog(
                                filterNull(title), onTapCreate: (String title) {
                              controller
                                  .updateBoard(filterNull(data?.id), title)
                                  .then(
                                      (value) => Get.back(closeOverlays: true));
                            }));
                  },
                  icon: const Icon(Icons.drive_file_rename_outline)),
              const Spacer(),
              _addDropDown(context, data?.id)
              // TextButton.icon(
              //     onPressed: null,
              //     icon: const Icon(Icons.settings_outlined),
              //     label: const Text("Customize Table",
              //         style: TextStyle(fontWeight: FontWeight.w600)))
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
              child: HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: Get.width,
            isFixedHeader: true,
            headerWidgets:
                _getTitleWidget(context, filterNullList(data?.columns)),
            isFixedFooter: false,
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            // rightSideChildren:
            //     _generateRightViewRows(filterNullList(data?.rows)),
            itemCount: filterNullInt(data?.rows?.length),
            rowSeparatorWidget: const Divider(
              color: Colors.black38,
              height: 1.0,
              thickness: 0.0,
            ),
            leftHandSideColBackgroundColor: colorWhite,
            rightHandSideColBackgroundColor: colorWhite,
            itemExtent: 55,
          ))
        ]));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/logo.png"),
                const Text(
                  'Ice T',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            _addProfile(),
          ])),
      body: GetBuilder<OverviewboardController>(builder: (controller) {
        return FutureBuilder(
          future: controller.futureBoard,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: emptyView(context));
              }
              // return errorView(snapshot);
              else {
                if (snapshot.data!.isEmpty) {
                  return Center(child: emptyView(context));
                } else {
                  return Obx(() => Center(
                      child: _widgetOptions(context,
                          snapshot.data?[controller.obxPosition.value])));
                }
              }
            }
          },
        );
      }),
      drawer: Drawer(
          child: GetBuilder<OverviewboardController>(builder: (controller) {
        return FutureBuilder(
          future: controller.futureBoard,
          builder: (context, snapshot) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/logo.png"),
                    const Text(
                      'Ice T',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: controller.getItemCount(snapshot.data?.length),
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data?.length == null ||
                      index > snapshot.data?.length - 1) {
                    return Container(
                        margin: const EdgeInsets.all(12),
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add_sharp),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                          onPressed: () => {
                            Get.back(),
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    newBoardDialog(onTapBoardSelection:
                                        (SelectedBoard board) {
                                      switch (board) {
                                        case SelectedBoard.STOCK:
                                          break;
                                        case SelectedBoard.CUSTOM:
                                          {
                                            controller.callCustomBoard();
                                            break;
                                          }
                                      }
                                    }))
                          },
                          label: const Text("Add board"),
                        ));
                  } else {
                    return ListTile(
                      title: Row(children: [
                        const Icon(Icons.content_paste),
                        const SizedBox(width: 12),
                        Text(filterNull(
                          snapshot.data?[index]?.name,
                        ))
                      ]),
                      onTap: () {
                        controller.selectDrawer(index);
                        // _widgetOptions(context, snapshot.data?[index]);
                        Get.back();
                      },
                    );
                  }
                },
              ))
            ]);
          },
        );
      })),
    );
  }
}

class _MenuItem {
  const _MenuItem({
    required this.text,
    required this.icon,
    required this.color,
  });

  final String text;
  final IconData? icon;
  final Color color;
}

abstract class _MenuItems {
  static const List<_MenuItem> firstItems = [info, delete];
  static const info = _MenuItem(
      text: 'View full info', icon: Icons.info_outline, color: Colors.black38);
  static const delete = _MenuItem(
      text: 'Delete', icon: Icons.delete_outline, color: colorDeleteButton);

  static Widget buildItem(_MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: item.color, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: TextStyle(
              color: item.color,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, _MenuItem item) {
    switch (item) {
      case _MenuItems.info:
        //Do something
        break;
      case _MenuItems.delete:
        break;
    }
  }
}
