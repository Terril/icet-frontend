import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/colors.dart';

mixin OverviewboardDialogView {
  Dialog newBoardDialog({required Function onTapBoardSelection}) => Dialog(
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'New board',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                Get.back(closeOverlays: true);
              },
            )
          ]),
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
                onTapBoardSelection(SelectedBoard.STOCK);
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
                onTapBoardSelection(SelectedBoard.CUSTOM);
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

  Dialog newChecklistDialog({required Function onTapCreate}) {
    final titleEditor = TextEditingController();
    final descEditor = TextEditingController();
    return Dialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: Get.width / 2.5,
        width: Get.height / 1.7,
        margin:
        const EdgeInsets.only(top: 20, left: 32, right: 32, bottom: 32),
        child: Column(children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  Get.back();
                },
              )),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New Checklist',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w700),
                    ),
                    Visibility(visible: false, child: OutlinedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                            )),
                        onPressed: () {
                          Get.back();
                        },
                        child: Row(children: [
                          const Icon(
                            Icons.lightbulb,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'View recommended checklists',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w200),
                          ),
                        ])))
                  ]),
              const SizedBox(height: 16.0),
              const Text(
                'Checklist title *',
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
                        hintText: 'Checklist title'),
                  )),
              const SizedBox(height: 16.0),
              const Text(
                'Description',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900),
              ),
              Container(
                  height: Get.width / 7,
                  margin: const EdgeInsets.only(top: 8),
                  child: TextField(
                        controller: descEditor,
                        maxLines: 10,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: colorGreyField),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Input description'),
                      )),
              const SizedBox(height: 16.0),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8), // <-- Radius
                        ),
                        backgroundColor: colorBlueButton),
                    onPressed: () {
                      onTapCreate(titleEditor.text, descEditor.text.isEmpty ? "" : descEditor.text);
                      Get.back(closeOverlays: true);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Create',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorWhite)),
                    )),
              )
            ],
          )
        ]),
      ),
    );
  }

  onTapCreate() {
    print("Create cakked");
  }
}

enum SelectedBoard {
  STOCK, CUSTOM
}
