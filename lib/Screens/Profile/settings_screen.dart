import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../Scontrollers/ProfileController/settings_screen_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsScreenController settingsScreenController = Get.put(SettingsScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            settingsScreenController.check=true;
          settingsScreenController.handleBackNavigation();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: PopScope(
        canPop: false,

        onPopInvokedWithResult: (didPop, result) {
          settingsScreenController.check=false;
          settingsScreenController.handleBackNavigation();
        },
        child: Column(
          children: [
            const Gap(20),
            Row(
              children: [
                const Gap(20),
                const Text(
                  "Notification",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Obx(() {
                  final artboard = settingsScreenController.riveArtboard.value;
                  if (artboard == null) {
                    return const CircularProgressIndicator(); // Show loading state
                  } else {
                    return GestureDetector(
                      onTap: () {
                        settingsScreenController.toggle();
                      },
                      child: SizedBox(
                        width: 90,
                        height: 50,
                        child: Rive(
                          artboard: artboard,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  }
                }),
                const Gap(10),
              ],
            ),
            Row(
              children: [
                const Gap(20),
                const Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Obx(() {
                  final artboard = settingsScreenController.riveArtboard2.value;
                  if (artboard == null) {
                    return const CircularProgressIndicator(); // Show loading state
                  } else {
                    return GestureDetector(
                      onTap: () {
                        settingsScreenController.toggle2();
                      },
                      child: SizedBox(
                        width: 80,
                        height: 70,
                        child: Rive(
                          artboard: artboard,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  }
                }),
                const Gap(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
