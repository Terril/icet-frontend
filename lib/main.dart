import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'icetbinding.dart';
import 'overviewboard/overviewboard.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/overviewboard',
    getPages: [
      GetPage(name: '/overviewboard', page: () => OverviewboardView(), binding: IceTBinding()),
    ],
  ));
}

