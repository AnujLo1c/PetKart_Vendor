import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

import '../theme_controller.dart';

class SettingsScreenController extends GetxController {
  ThemeController themeController=Get.find<ThemeController>();
  Rx<Artboard?> riveArtboard = Rx<Artboard?>(null);
  Rx<Artboard?> riveArtboard2 = Rx<Artboard?>(null);
  SMIInput<bool>? toggleInput;
  SMIInput<bool>? toggleInput2;
bool check=true;
// BottomNavController bottomNavController=Get.find<BottomNavController>();
  @override
  void onInit() {
    super.onInit();

    rootBundle.load('assets/rive/toggle.riv').then((data) async {
      await RiveFile.initialize();
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      final controller = StateMachineController.fromArtboard(
        artboard,
        'State Machine',
      );
// print(controller);
      if (controller != null) {
        artboard.addController(controller);

        toggleInput = controller.findInput<bool>('IsOn');
      }

      riveArtboard.value = artboard;
    });
    rootBundle.load('assets/rive/dark_light_switch.riv').then((data) async {

      final file2 = RiveFile.import(data);
      final artboard2 = file2.mainArtboard;

      final controller2 = StateMachineController.fromArtboard(
        artboard2,
        'State Machine 1',
      );

      if (controller2 != null) {
        artboard2.addController(controller2);

        toggleInput2 = controller2.findInput<bool>('isDark');
        // toggleInput2?.value=themeController.isDarkMode.value;
      // themeController.toggleTheme();

      }

      riveArtboard2.value = artboard2;
    });
  }

  void toggle() {
    if (toggleInput != null) {
      toggleInput!.value = !(toggleInput!.value);
    }
  }
  void toggle2() {
    if (toggleInput2 != null) {
      toggleInput2!.value = !(toggleInput2!.value);
      themeController.toggleTheme();
      print('Toggled theme: ${themeController.themeMode.value}');
 // bottomNavController.currentPage.value=3;
    }
  }
bool block=true;
  void handleBackNavigation() {
if(check&& block){
  block=false;
    Get.offNamed("/home");
print("true wala");
}
else if(!check && block){
  block=false;
    Get.offNamed("/home");
print("false wala");
}
  }
}
