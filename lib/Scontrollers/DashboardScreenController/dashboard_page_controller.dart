import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:petkart_vendor/Models/income_model.dart';
import 'package:petkart_vendor/Scontrollers/bottom_nav_controller.dart';

class DashboardPageController extends GetxController{
final int temp=0;
BottomNavController bottomNavController=Get.find<BottomNavController>();
  void navToOrders() {
    bottomNavController.onBNavItemTap(1);
  }
IncomeModel? incomeData;
//TODO:: fix fetching after new upload
Stream<List<Map<String, dynamic>>> fetchPetOrders() async* {
  String vendorDocName=EmailPassLoginAl().getEmail();
  // Listen to changes in the vendorusers document
  final vendorDocSnapshot = FirebaseFirestore.instance
      .collection('vendorusers')
      .doc(vendorDocName)
      .snapshots();

  await for (final snapshot in vendorDocSnapshot) {
    if (snapshot.exists) {
      // Get the petorders field as a list
      final petOrderIds = snapshot.data()?['petorders'] as List<dynamic>? ?? [];
final petOrderIdsLimit=petOrderIds.take(2).toList();
      // Fetch data from petorders collection for each document name in the list
      final List<Map<String, dynamic>> petOrdersData = [];

      for (final orderId in petOrderIdsLimit) {
        final orderSnapshot = await FirebaseFirestore.instance
            .collection('petorders')
            .doc(orderId.toString())
            .get();

        if (orderSnapshot.exists) {
          petOrdersData.add(orderSnapshot.data() ?? {});
        }
      }

      // Emit the collected data
      yield petOrdersData;
    } else {
      yield [];
    }
  }
}
}