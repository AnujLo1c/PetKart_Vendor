import 'package:get/get.dart';
import 'package:petkart_vendor/Models/income_model.dart';
import 'package:petkart_vendor/Scontrollers/bottom_nav_controller.dart';

class DashboardPageController extends GetxController{
final int temp=0;
BottomNavController bottomNavController=Get.find<BottomNavController>();
  void navToOrders() {
    bottomNavController.onBNavItemTap(1);
  }
IncomeModel? incomeData;
}