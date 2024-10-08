import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Screens/DashboardScreen/dashboard_page.dart';
import 'package:petkart_vendor/Screens/EarningScreen/earning_page.dart';
import 'package:petkart_vendor/Screens/OrderScreen/order_page.dart';
import 'package:petkart_vendor/Screens/ProductScreen/product_page.dart';
import 'package:petkart_vendor/Screens/Profile/profile_page.dart';
class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  var appbarName = ["Hi! \nAnuj Lowanshi", "Orders", "Products", "Earnings", "Profile"];

  List<Widget> pages = [
    const DashboardPage(),
    const OrderPage(),
    const ProductPage(),
    const EarningPage(),
    const ProfilePage(),
  ];

  PageController pageController = PageController(initialPage: 0);


  onBNavItemTap(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }


  void onPageChanged(int index) {
    selectedIndex.value = index;
  }
}
