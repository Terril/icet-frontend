import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:icet/const/colors.dart';
import 'package:icet/overviewboard/assets/assets.dart';
import 'package:icet/signupsignin/signin.dart';
import 'package:icet/signupsignin/signup.dart';
import 'icetbinding.dart';
import 'overviewboard/overviewboard.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(scaffoldBackgroundColor: colorBlue),
    initialRoute: '/signin',
    getPages: [
      GetPage(name: '/overviewboard', page: () => OverviewboardView(), binding: IceTBinding()),
      GetPage(name: '/signup', page: () => SignupView(), binding: IceTBinding()),
      GetPage(name: '/signin', page: () => SigninView(), binding: IceTBinding()),
    ],
  ));
}

