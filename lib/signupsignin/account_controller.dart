import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/cachemanager.dart';
import '../datamodel/token.dart';
import '../datamodel/user.dart';
import '../extension/ext.dart';
import '../logs.dart';
import '../provider/apiServiceProvider.dart';

class AccountController extends GetxController with CacheManager {
  late APIServiceProvider provider;
  late String _pass;
  late String _email;
  late String _reinputPass;
  var _trx;
  var dataAvailable = false.obs;
  TextEditingController textPasswordController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();

  RxBool enableButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    provider = APIServiceProvider();
    textPasswordController.addListener(() {
      _checkButtonEnableLogic();
    });

    textEmailController.addListener(() {
      _checkButtonEnableLogic();
    });
  }

  void _checkButtonEnableLogic() {
    if (_email.isNotEmpty && _pass.isNotEmpty) {
      enableButton.value = true;
    } else {
      enableButton.value = false;
    }
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    _email = filterNull(value);
    return filterNull(value).isNotEmpty && !regex.hasMatch(_email)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePassword(String? value) {
    // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])';
    // RegExp regex = RegExp(pattern);
    _pass = filterNull(value);
    // final regex = RegExp(r"\s");
    return filterNull(value).isNotEmpty && !(_pass.length > 5)
        ? 'Password should have a minimum of 6 characters'
        : null;
  }

  String? validateReInputPassword(String? value) {
    _reinputPass = filterNull(value);
    return filterNull(value).isNotEmpty && _pass != value
        ? 'Password doesn\'t match'
        : null;
  }

  void performUserSignUp() async {
    if (_email.isNotEmpty && _reinputPass.isNotEmpty) {
      Map<String, String> map = HashMap();
      map["email"] = _email;
      map["password"] = _pass;
      await provider
          .signupUser(map)
          .then((response) {
            print(response);
            if (response != null) _trx = User.fromJson(response.body);
          })
          .catchError((err) => print('Error!!!!! : ${err}'))
          .whenComplete(() => dataAvailable.value = _trx != null);
    }
  }

  void performUserSignIn(Function func) async {
    if (_email.isNotEmpty && _pass.isNotEmpty) {

      Map<String, String> map = HashMap();
      map["username"] = _email;
      map["password"] = _pass;
      await provider
          .signinUser(map)
          .then((response) {
            if (response != null) {
              _trx = Token.fromJson(response.body);
              Logger.printLog(message: filterNull((_trx as Token).token));
              saveToken((_trx as Token).token);
              saveLoginState(true);
              func(true);
            }
          })
          .catchError((err) => print('Error!!!!! : $err'))
          .whenComplete(
              () => {dataAvailable.value = _trx != null, func(false)});
    }
  }

  @override
  void onClose() {
    textPasswordController.dispose();
    super.onClose();
  }
}
