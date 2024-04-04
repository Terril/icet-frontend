import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:icet/extension/ext.dart';

import '../const/colors.dart';
import '../datamodel/boards.dart';
import '../datamodel/columns.dart';
import '../datamodel/rows.dart';
import 'assets/assets.dart';
import 'overviewboard_controller.dart';
import 'overviewboard_dialog.dart';

class OverviewboardView extends GetView<OverviewboardController>
    with OverviewboardDialogView {
  OverviewboardView({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  String selectedValue = "1";

  void onClickCustomizableTable() {
    print("search button clicked");
  }

  double widthSize = (Get.width / 6);

  List<Widget> _getTitleWidget(List<Columns> items) {
    double widthSize = (Get.width / (items.length + 2));
    List<Widget> widget = <Widget>[];
    widget.add(_getTitleItemWidget('ASSET', widthSize));
    for (var element in items) {
      widget.add(_getTitleItemWidget(
          filterNull(element.name?.toUpperCase()), widthSize));
    }
    return widget;
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: const Color.fromARGB(249, 250, 251, 255),
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(label,
          maxLines: 2,
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
      child: Text(filterNull(itemRowWidget[index].name)),
    );
  }

  List<Rows> itemRowWidget = <Rows>[];
  List<Columns> itemColumnWidget = <Columns>[];

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    List<Widget> widget = <Widget>[];
    double widthSize = (Get.width / (itemColumnWidget.length + 2));
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
              showGeneralDialog<bool>(
                context: context,
                transitionBuilder: (context, a1, a2, widget) {
                  return SlideTransition(
                    position: Tween(
                            begin: const Offset(1, 0),
                            end: const Offset(0.5, 0))
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
                  return AssetsView(boardId);
                },
              ).then((value) => filterBoolNull(value) ? controller.loadBoard() : null);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => newChecklistDialog(
                          onTapCreate: (String title, String desc) {
                        controller.addColumns(filterNull(boardId), title, desc);
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
            headerWidgets: _getTitleWidget(filterNullList(data?.columns)),
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/images/logo.png"),
              const Text(
                'Ice T',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
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
