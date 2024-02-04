import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'overviewboard_controller.dart';

class OverviewboardView extends GetView<OverviewboardController> {
   OverviewboardView({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void onClickCustomizableTable() {
    print("search button clicked");
  }

   double widthSize = (Get.width / 6);

  // const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
  // Text("Stock watchlist",
  // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
  // IconButton(
  // iconSize: 20,
  // icon: Icon(Icons.edit),
  // onPressed: null,
  // ),
  // Spacer(),
  // Text("Some Data")
  // ]),

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
    return Container(
        color: const Color(0xffEBF5FF),
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
          leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
          rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
          itemExtent: 55,
        ));
  }


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ice T'),
      ),
      body: FutureBuilder(
        future: controller.fetchBoard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _widgetOptions();
          } else {
            if (snapshot.hasError) {
              print('${snapshot.data}');
              print('${snapshot.stackTrace}');
              return _widgetOptions();
            }
            // return errorView(snapshot);
            else {
              print('${snapshot.data?.body}');
              print('${snapshot.data?.request?.headers}');
              return Center(
                child: _widgetOptions(),
              );
            }
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Stock watchlist'),
              onTap: () {
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              onTap: () {
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              onTap: () {
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
