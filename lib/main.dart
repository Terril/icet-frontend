import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icet/cache/cachemanager.dart';
import 'package:icet/const/colors.dart';
import 'package:icet/logs.dart';
import 'package:icet/signupsignin/signin.dart';
import 'package:icet/signupsignin/signup.dart';
import 'auth/auth.dart';
import 'icetbinding.dart';
import 'overviewboard/overviewboard.dart';

Future<void> main() async {
  await GetStorage.init("icet-pref");
  WidgetsFlutterBinding.ensureInitialized();

  final Auth auth = Auth();
  await auth.isLogged().then((value) =>
      runApp(IcetApp(value))
  );

}

class IcetApp extends StatelessWidget with CacheManager {
   IcetApp(this.isLoggedIn, {super.key});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: colorBlue),
      initialRoute: isLoggedIn ? '/overviewboard' : '/signin',
      getPages: [
        GetPage(name: '/overviewboard', page: () => OverviewboardView(), binding: IceTBinding()),
        GetPage(name: '/signup', page: () => SignupView(), binding: IceTBinding()),
        GetPage(name: '/signin', page: () => SigninView(), binding: IceTBinding()),
      ],
    );
  }
}

