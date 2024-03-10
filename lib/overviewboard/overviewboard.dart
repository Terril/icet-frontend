import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:icet/extension/stringext.dart';

import '../const/colors.dart';
import '../datamodel/boards.dart';
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

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('ASSET', widthSize),
      _getTitleItemWidget('INTEREST LEVEL', widthSize),
      _getTitleItemWidget('PRODUCTS RATING', widthSize),
      _getTitleItemWidget('FINANCIALS', widthSize),
      _getTitleItemWidget('BUSINESS MODEL', widthSize),
      _getTitleItemWidget('MANAGEMENT', widthSize),
      _getTitleItemWidget('VALUATION', widthSize),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: const Color.fromARGB(249, 250, 251, 255),
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  static const List<String> stockName = [
    "Apple",
    "Google",
    "Tesla",
    "Splunk",
    "Sea",
    "Arm"
  ];
  static const List<String> stockNameInfo = [
    "Apple",
    "Google",
    "Tesla",
    "Splunk",
    "Sea",
    "Arm"
  ];
  static const List<bool> stockStatus = [true, false, false, true, false, true];

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(stockName[index]),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: widthSize,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                  stockStatus[index]
                      ? Icons.notifications_off
                      : Icons.notifications_active,
                  color: stockStatus[index] ? Colors.red : Colors.green),
              Text(stockStatus[index] ? 'Disabled' : 'Active')
            ],
          ),
        ),
        Container(
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
        ),
        Container(
          width: widthSize,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(stockNameInfo[index]),
        ),
        Container(
          width: widthSize,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(stockNameInfo[index]),
        ),
        Container(
          width: widthSize,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(stockNameInfo[index]),
        ),
        Container(
          width: widthSize,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(stockNameInfo[index]),
        ),
      ],
    );
  }

  List<String> list = <String>['New asset', 'New checklist'];

  Widget _addDropDown(BuildContext context) {
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
              showGeneralDialog(
                context: context,
                transitionBuilder: (context, a1, a2, widget) {
                  return SlideTransition(
                    position: Tween(begin: const Offset(1, 0), end: const Offset(0.5, 0)).animate(a1),
                    child: widget,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    ) {
                  return const AssetsView();
                },
              );
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      newChecklistDialog(onTapCreate: () {
                        print("Create called");
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

  Widget _widgetOptions(BuildContext context, List<Boards?>? data) {
    String? title = data?[0]?.name;
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
              _addDropDown(context)
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
            headerWidgets: _getTitleWidget(),
            isFixedFooter: false,
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: 6,
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
      body: FutureBuilder(
        future: controller.fetchBoard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _widgetOptions(context, null);
          } else {
            if (snapshot.hasError) {
              return _widgetOptions(context, null);
            }
            // return errorView(snapshot);
            else {
              return Center(child: _widgetOptions(context, snapshot.data));
            }
          }
        },
      ),
      drawer: Drawer(
          child: FutureBuilder(
        future: controller.fetchBoard(),
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
                    style:
                        TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: controller.getItemCount(snapshot.data?.length),
              itemBuilder: (BuildContext context, int index) {
                if (index > snapshot.data!.length - 1) {
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
                              builder: (BuildContext context) => newBoardDialog)
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
                      Get.back();
                    },
                  );
                }
              },
            ))
          ]);
        },
      )),
    );
  }
}
