import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../overviewboard_controller.dart';

class AssetsView extends GetView<OverviewboardController> {
  const AssetsView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Flexible(
        child: FractionallySizedBox(
            alignment: FractionalOffset.topRight,
            widthFactor: 0.5,
            child: Container(
              padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text(
                      'New Asset',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: const Icon(Icons.delete_outlined),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ]),
                ]))),
      ),
    );
  }
}
