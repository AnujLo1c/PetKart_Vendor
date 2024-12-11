import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Scontrollers/bottom_nav_controller.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController bottomNavController = Get.put(BottomNavController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 20,
        title: Obx(
              () => Text(
            bottomNavController
                .appbarName[bottomNavController.selectedIndex.value],
            style: TextStyle(
              fontSize: bottomNavController.selectedIndex.value == 0 ? 15 : 20,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Obx(() {
            return bottomNavController.selectedIndex.value != 4
                ? IconButton(
              onPressed: () {
                Get.toNamed("/noti_screen");
              },
              icon: const Icon(Icons.notifications_active),
            )
                : const SizedBox(); // Return an empty widget when selectedIndex != 0
          }),
        ],
      ),

      body: PageView(
        controller: bottomNavController.pageController,
        onPageChanged: bottomNavController.onPageChanged,
        children: bottomNavController.pages,
      ),

      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.indeterminate_check_box_sharp),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits_outlined),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Earnings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: bottomNavController.selectedIndex.value,
          selectedItemColor: Get.theme.colorScheme.primary,
          onTap: (value) => bottomNavController.onBNavItemTap(value),
          unselectedFontSize: 11,
          selectedFontSize: 11,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
