import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/themes.dart';



class ThemeController extends GetxController {

  Rx<ThemeMode> themeMode=ThemeMode.system.obs;
  @override
  void onInit() {
    super.onInit();
    //TODO//set thememode to system
    themeMode.value=ThemeMode.light;
  }

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
    print('Theme changed to: ${themeMode.value}');
    // Get.forceAppUpdate();
    // Get.reload<BottomNavController>();
  }


  ThemeData get lightTheme => MyAppTheme.lightTheme;
  ThemeData get darkTheme => MyAppTheme.darkTheme;
}
