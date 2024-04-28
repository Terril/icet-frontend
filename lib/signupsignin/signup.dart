import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/utils.dart';
import 'package:icet/signupsignin/account_controller.dart';

import '../const/colors.dart';
import '../extension/ext.dart';

class SignupView extends GetView<AccountController> {
  SignupView({super.key});

  void _submitCreateAccount() {
    controller.performUserSignUp((bool res) {
      if (!res) {
        showInSnackBar("Unable to log in with provided credentials");
      }
    });
  }

  void _navigateToBoards() {
    Get.toNamed('/overviewboard');
  }

  void _navigateToSignIn() {
    Get.toNamed('/signin');
  }

  @override
  Widget build(context) {
    double txtWidth = Get.width * 0.3;
    return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
            body: Obx(() => !controller.dataAvailable.value
                ? Center(
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
                            style: TextStyle(
                                fontSize: 36.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text("Decide Better",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: colorGrey,
                                fontSize: 20)),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text("Sign up",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: colorGrey,
                                                    fontSize: 20)),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 24),
                                              child: const Text("Your email",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: colorGrey,
                                                      fontSize: 14)),
                                            ),
                                            Container(
                                                width: txtWidth,
                                                margin: const EdgeInsets.only(
                                                    top: 8),
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator:
                                                      controller.validateEmail,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    colorGreyField),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      hintText:
                                                          'name@example.com'),
                                                )),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              child: const Text("Password",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: colorGrey,
                                                      fontSize: 14)),
                                            ),
                                            Container(
                                                width: txtWidth,
                                                margin: const EdgeInsets.only(
                                                    top: 8),
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: controller
                                                      .validatePassword,
                                                  obscureText: true,
                                                  enableSuggestions: false,
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    colorGreyField),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      hintText: '********'),
                                                )),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              child: const Text(
                                                  "Re-input password",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: colorGrey,
                                                      fontSize: 14)),
                                            ),
                                            Container(
                                                width: txtWidth,
                                                margin: const EdgeInsets.only(
                                                    top: 8),
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: controller
                                                      .validateReInputPassword,
                                                  obscureText: true,
                                                  enableSuggestions: false,
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    colorGreyField),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      hintText: '********'),
                                                )),
                                            Container(
                                                width: txtWidth,
                                                margin: const EdgeInsets.only(
                                                    top: 24.0),
                                                child: ElevatedButton.icon(
                                                  icon: controller
                                                          .enableLoader.value
                                                      ? Container(
                                                          width: 24,
                                                          height: 24,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child:
                                                              const CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 3,
                                                          ),
                                                        )
                                                      : const Icon(
                                                          Icons.feedback,
                                                          color: Colors
                                                              .transparent),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // <-- Radius
                                                          ),
                                                          backgroundColor:
                                                              colorBlueButton),
                                                  onPressed:
                                                      _submitCreateAccount,
                                                  label: const Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Text(
                                                        'Create account',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: colorWhite)),
                                                  ),
                                                )),
                                            InkWell(
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 16),
                                                  child: RichText(
                                                    textAlign: TextAlign.left,
                                                    text: const TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                'Already registered?',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    colorGrey,
                                                                fontSize: 14)),
                                                        TextSpan(
                                                            text: ' Sign in',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    colorBlueButton,
                                                                fontSize: 14)),
                                                      ],
                                                    ),
                                                  )),
                                              onTap: () {
                                                _navigateToSignIn();
                                              },
                                            ),
                                          ])))))
                    ],
                  ))
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(children: <Widget>[
                                  Image.asset("assets/images/righttick.png"),
                                  Container(
                                      margin: const EdgeInsets.only(top: 24.0),
                                      child: const Text(
                                        'Thank you for signing up',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(top: 8.0),
                                      child: const Text(
                                        'Your account has been created successfully',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14.0),
                                      )),
                                  Container(
                                      width: txtWidth,
                                      margin: const EdgeInsets.only(top: 24.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8), // <-- Radius
                                            ),
                                            backgroundColor: colorBlueButton),
                                        onPressed: _navigateToBoards,
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text('Start using Ice-T',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: colorWhite)),
                                        ),
                                      )),
                                ])))
                      ])))));
  }
}
