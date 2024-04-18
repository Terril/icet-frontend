import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:icet/extension/ext.dart';
import 'package:icet/utils.dart';

import '../const/colors.dart';
import '../datamodel/boards.dart';
import '../datamodel/columns.dart';
import '../datamodel/rows.dart';
import '../provider/apiServiceProvider.dart';
import 'assets/assets.dart';
import 'overviewboard_controller.dart';
import 'overviewboard_dialog.dart';

class OverviewboardView extends GetView<OverviewboardController>
    with OverviewboardDialogView {
  OverviewboardView({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  String selectedValue = "1";

  void onTapProfilePic() {
    print("Profile Pic clicked");
  }

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

  double widthSize = (Get.width / 6);

  List<Widget> _getTitleWidget(BuildContext context, List<Columns> items) {
    double widthSize =
        (Get.width / (items.length + 2)); // Earlier items.length + 2
    List<Widget> widget = <Widget>[];
    widget.add(_getTitleItemWidget(context, Columns(name: 'ASSET'), widthSize));
    for (var element in items) {
      widget.add(_getTitleItemWidget(context, element, widthSize));
    }
    return widget;
  }

  Widget _getTitleItemWidget(BuildContext context, Columns col, double width) {
    return _addColumnDropDown(context, col, width);
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

  List<Rows> itemRowWidget = <Rows>[];
  List<Columns> itemColumnWidget = <Columns>[];

  Boards? board = null;

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
          child: Obx(() => DropdownButton(
                underline: const SizedBox(),
                iconSize: 0.0,
                onChanged: (newValue) {
                  controller.setSelected(newValue!);
                },
                value: controller.selected.value,
                items: controller.dropdownItems.map((selectedType) {
                  return DropdownMenuItem(
                    value: selectedType,
                    child: Text(
                      selectedType,
                    ),
                  );
                }).toList(),
              )), //([index]),
        );
        widget.add(sectionOne);
      } else {
        Widget sectionOthers = Container(
          width: widthSize,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check_circle, color: colorCheckMark),
            ],
          ),
        );
        widget.add(sectionOthers);
      }
    }

    return Row(children: widget);
  }

  List<String> list = <String>['New asset', 'New checklist'];

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
              maxLines: 2,
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
          _MenuItems.onChanged(context, column, value!);
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

              // TextField(
              //     controller: controller.titleController,
              //     enabled: false,
              //     decoration: InputDecoration(
              //       label: Text(filterNull(title),
              //           style: const TextStyle(
              //               fontSize: 21.0, fontWeight: FontWeight.bold)),
              //     )),
              const SizedBox(width: 12.5),
              IconButton(
                  onPressed: () async {},
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
            InkWell(
                onTap: () {
                  onTapProfilePic();
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://source.unsplash.com/50x50/?portrait',
                      scale: 1.0),
                )),
          ])),
      body: GetBuilder<OverviewboardController>(builder: (controller) {
        return FutureBuilder(
          future: controller.futureBoard,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _widgetOptions(context, null);
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
  final IconData icon;
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

  static void onChanged(BuildContext context, Columns column, _MenuItem item) {
    switch (item) {
      case _MenuItems.info:
        //Do something
        break;
      case _MenuItems.delete:
        UIUtils.showDeleteDialog(
            context,
            "Are you sure you want to delete this checklist? \n"
            "All notes within will be deleted and cannot be \nretrieved.",
            onCloseClicked: () {
          Get.back(closeOverlays: true);
        }, onDeleteClicked: () {
          OverviewboardController controller = OverviewboardController();
          controller
              .deleteColumn(filterNull(column.id))
              .then((value) => value ? controller.loadBoard() : null);

          Get.back(closeOverlays: true);
        });
        break;
    }
  }
}
