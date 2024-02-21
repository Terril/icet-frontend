import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icet/signupsignin/signup_controller.dart';

import '../const/colors.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(child: Card(
          child: Padding(padding: const EdgeInsets.all(32.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
            const Text("Sign up",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorGrey,
                      fontSize: 20)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text("Max MagiX,",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16)),
            )
          ]))),
    ));
  }
}
