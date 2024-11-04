import 'package:get/get.dart';
import 'package:petkart_vendor/Models/order_model.dart';

class OrderScreenController extends GetxController {
  var selectedTab = 0.obs;

  var totalOrders = <OrderModel>[
    OrderModel(
      id: '#202110242004',
      date: '2 Aug 2024 04:25 PM',
      customerName: 'Anuj Lowanshi',
      deliveryStatus: 'Placed',
      imageUrl: 'assets/img/cat.png', // update with your assets path
      price: 3000,
    ),OrderModel(
      id: '#202110242004',
      date: '2 Aug 2024 04:25 PM',
      customerName: 'Anuj Lowanshi',
      deliveryStatus: 'Placed',
      imageUrl: 'assets/img/cat.png', // update with your assets path
      price: 3000,
    ),
    // Add more orders as needed
  ].obs;

  var pendingOrders = <OrderModel>[].obs;
  var placedOrders = <OrderModel>[].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
