import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/utils.dart';
import 'package:icet/signupsignin/account_controller.dart';

import '../cache/cachemanager.dart';
import '../const/colors.dart';

class SigninView extends GetView<AccountController> {
  SigninView({super.key});

  void _submitForAccountLogin() {
    controller.performUserSignIn((bool res) {
      if (res) {
        _navigateToBoards();
      }
    });
  }

  void _navigateToBoards() {
    Get.toNamed('/overviewboard');
  }

  void _navigateToSignUp() {
    Get.toNamed('/signup');
  }

  @override
  Widget build(context) {
    double txtWidth = Get.width * 0.3;
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            const SizedBox(width: 15),
            const Text(
              'Ice T',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Text("Decide Better",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: colorGrey, fontSize: 20)),
        ),
        SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text("Sign in",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: colorGrey,
                                      fontSize: 20)),
                              Container(
                                margin: const EdgeInsets.only(top: 24),
                                child: const Text("Your email",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: colorGrey,
                                        fontSize: 14)),
                              ),
                              Container(
                                  width: txtWidth,
                                  margin: const EdgeInsets.only(top: 8),
                                  child: TextFormField(
                                    controller:
                                    controller.textEmailController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: controller.validateEmail,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: colorGreyField),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        hintText: 'name@example.com'),
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: const Text("Password",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: colorGrey,
                                        fontSize: 14)),
                              ),
                              Container(
                                  width: txtWidth,
                                  margin: const EdgeInsets.only(top: 8),
                                  child: TextFormField(
                                    controller:
                                        controller.textPasswordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: controller.validatePassword,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: colorGreyField),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        hintText: '********'),
                                  )),
                              Container(
                                  width: txtWidth,
                                  margin: const EdgeInsets.only(top: 24.0),
                                  child: Obx(() => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8), // <-- Radius
                                            ),
                                            backgroundColor:  controller.enableButton.value
                                                ? colorBlueButton
                                                : colorGreyField),
                                        onPressed: _submitForAccountLogin,
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text('Sign in',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: colorWhite)),
                                        ),
                                      ))),
                              InkWell(
                                child: Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: const TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Not registered?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: colorGrey,
                                                  fontSize: 14)),
                                          TextSpan(
                                              text: ' Create account',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: colorBlueButton,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    )),
                                onTap: () {
                                  _navigateToSignUp();
                                },
                              ),
                            ])))))
      ],
    )));
  }
}

// Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// Card(
// color: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// child: Padding(
// padding: const EdgeInsets.all(32.0),
// child: Column(children: <Widget>[
// Image.asset("assets/images/righttick.png"),
// Container(
// margin: const EdgeInsets.only(top: 24.0),
// child: const Text(
// 'Thank you for signin',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 20.0,
// fontWeight: FontWeight.bold),
// )),
// Container(
// margin: const EdgeInsets.only(top: 8.0),
// child: const Text(
// 'Your account has been created successfully',
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 14.0),
// )),
// Container(
// width: txtWidth,
// margin: const EdgeInsets.only(top: 24.0),
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(
// 8), // <-- Radius
// ),
// backgroundColor: colorBlueButton),
// onPressed: _navigateToBoards,
// child: const Padding(
// padding: EdgeInsets.all(10.0),
// child: Text('Start using Ice-T',
// style: TextStyle(
// fontWeight: FontWeight.w500,
// color: colorWhite)),
// ),
// )),
// ])))
// ]))
