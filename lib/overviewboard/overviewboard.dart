import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:icet/extension/stringext.dart';

import '../const/colors.dart';
import 'overviewboard_controller.dart';

class OverviewboardView extends GetView<OverviewboardController> {
  OverviewboardView({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  String selectedValue = "1";

  void onClickCustomizableTable() {
    print("search button clicked");
  }

  double widthSize = (Get.width / 6);

  Dialog newBoardDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: Get.width / 3,
      width: Get.height,
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New board',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
                ),
                 IconButton(icon:  const Icon(Icons.cancel_outlined), onPressed: () { Get.back(); },)
              ]
          ),
          const SizedBox(height: 10.0),
          const Text(
            'What are you looking to analyse?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w200),
          ),
          const SizedBox(height: 10.0),
          Row(children: <Widget>[
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
              )),
              onPressed: () {
                Get.back();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 14.0),
                      decoration: BoxDecoration(
                          color: colorBlue100,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, bottom: 30, right: 90, left: 90),
                          child: Image.asset('assets/images/stock_icon.png'))),
                  const Text("Stocks")
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
              )),
              onPressed: () {
                Get.back();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 14.0),
                      decoration: const BoxDecoration(
                        color: colorBlue100,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 35, bottom: 35, right: 90, left: 90),
                          child:
                              Image.asset('assets/images/u_plus-circle.png'))),
                  const Text("Custom")
                ],
              ),
            )
          ])
        ],
      ),
    ),
  );

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

  Widget _widgetOptions() {
    String title = filterNull("param.name");
    return Container(
        color: colorBlue,
        margin: const EdgeInsets.only(
          left: 60,
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
                title,
                style: const TextStyle(
                    fontSize: 21.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12.5),
              IconButton(
                  onPressed: () async {},
                  icon: const Icon(Icons.drive_file_rename_outline)),
              const Spacer(),
              TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.settings_outlined),
                  label: const Text("Customize Table",
                      style: TextStyle(fontWeight: FontWeight.w600)))
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
            return _widgetOptions();
          } else {
            if (snapshot.hasError) {
              return _widgetOptions();
            }
            // return errorView(snapshot);
            else {
              return Center(child: _widgetOptions());
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
                if (index == 0) {
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
