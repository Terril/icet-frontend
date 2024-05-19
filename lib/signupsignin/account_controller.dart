import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../cache/cachemanager.dart';
import '../datamodel/token.dart';
import '../datamodel/error.dart';
import '../extension/ext.dart';
import '../logs.dart';
import '../provider/apiServiceProvider.dart';

class AccountController extends GetxController with CacheManager {
  late APIServiceProvider provider;
  String _pass = "";
  String _email = "";
  late String _reinputPass;
  var _trx;
  var dataAvailable = false.obs;
  TextEditingController textPasswordController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textRePasswordController = TextEditingController();

  RxBool enableButton = false.obs;
  RxBool enableLoader = false.obs;
  bool isSignUp = false;

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

    textRePasswordController.addListener(() {
      _checkButtonEnableLogic();
    });
  }

  void _checkButtonEnableLogic() {
    if(isSignUp) {
      if (_email.isNotEmpty && _pass.isNotEmpty && _pass.length + 1 > 5
          && _reinputPass.isNotEmpty && _reinputPass.length + 1  > 5) {
        enableButton.value = true;
      } else {
        enableButton.value = false;
      }
    }
    else if (_email.isNotEmpty && _pass.isNotEmpty && _pass.length + 1 > 5) {
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

  void performUserSignUp(Function func) async {
    enableLoader.value = true;
    if (_email.isNotEmpty && _pass.isNotEmpty && _reinputPass.isNotEmpty) {
      Map<String, String> map = HashMap();
      map["email"] = _email;
      map["password"] = _pass;
      await provider
          .signupUser(map)
          .then((response) {
            enableLoader.value = false;
            print("${response.bodyString}  ${response.statusCode}") ;
            if (response != null && response.isOk) {
              _trx = Token.fromJson(response.body);
              Logger.printLog(message: filterNull((_trx as Token).token));
              saveToken((_trx as Token).token);
              saveLoginEmail(_email);
              saveLoginState(true);
            } else {
              var error = Error.fromJson(response.body);
              func(false, error);
            }
          })
          .catchError((err) => print('Error!!!!! : ${err}'))
          .whenComplete(() => dataAvailable.value = _trx != null);
    }
  }

  void performUserSignIn(Function func) async {
    enableLoader.value = true;
    if (_email.isNotEmpty && _pass.isNotEmpty) {
      Map<String, String> map = HashMap();
      map["username"] = _email;
      map["password"] = _pass;
      await provider
          .signinUser(map)
          .then((response) {
            enableLoader.value = false;
            if (response != null && response.isOk) {

              _trx = Token.fromJson(response.body);
              Logger.printLog(message: filterNull((_trx as Token).token));
              saveToken((_trx as Token).token);
              saveLoginEmail(_email);
              saveLoginState(true);
              func(true);
            } else {
              func(false);
            }
          })
          .catchError((err) => print('Error!!!!! : $err'))
          .whenComplete(
              () => {dataAvailable.value = _trx != null, func(false)});
    }
  }

}
