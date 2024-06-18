import 'package:flutter/material.dart';
import 'package:icet/ratings.dart';

import 'const/colors.dart';
import 'extension/ext.dart';

class UIUtils {
  static void showDeleteDialog(BuildContext context, String text,
      {required Function onCloseClicked, required Function onDeleteClicked}) {
    // set up the buttons
    Widget deleteButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // <-- Radius
          ),
          backgroundColor: colorDeleteButton),
      child: const Text(
        "Delete",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        onDeleteClicked();
      },
    );
    Widget closeButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
      ),
      child: const Text("Close", style: TextStyle(color: Colors.black)),
      onPressed: () {
        onCloseClicked();
      },
    );

    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
        contentPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        children: <Widget>[
          Column(children: <Widget>[
            const Icon(size: 24, Icons.info_outline),
            const SizedBox(height: 16),
            Text(text, textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: closeButton),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(child: deleteButton),
                ])
          ]),
        ]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(child: alert);
      },
    );
  }

  static Widget getCell(Rating rate) {
    Widget iconData = switch (rate) {
      Rating.pass => ButtonTheme(
        minWidth: 24.0,
        height: 24.0,
        child: Image.asset(
            'assets/images/ok_icon.png'),
      ),
      Rating.fail => ButtonTheme(
          minWidth: 24.0,
          height: 24.0,
          child: Image.asset(
              'assets/images/failure_icon.png')),
      Rating.unsure => ButtonTheme(
        minWidth: 24.0,
        height: 24.0,
        child: Image.asset(
            'assets/images/doubtful_icon.png'),
      ),
      Rating.mediocre => ButtonTheme(
          minWidth: 24.0,
          height: 24.0,
          child: Image.asset(
              'assets/images/annoyed_icon.png')),
      Rating.na => ButtonTheme(
          minWidth: 24.0,
          height: 24.0,
          child:Image.asset(
              'assets/images/clueless_icon.png')),
      _ => ButtonTheme(
          minWidth: 24.0,
          height: 24.0,
          child:Image.asset(
              'assets/images/doubtful_icon.png')),
    };

    return iconData;
  }
}
