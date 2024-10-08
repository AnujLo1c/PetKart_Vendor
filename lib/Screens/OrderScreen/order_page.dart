import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:petkart_vendor/Models/order_model.dart';
import '../../Scontrollers/OrderScreenController/order_screen_controller.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderScreenController orderScreenController = Get.put(OrderScreenController());

    return Obx(() {
      List<OrderModel> orders;

      // Switch to determine which orders to show
      switch (orderScreenController.selectedTab.value) {
        case 0:
          orders = orderScreenController.totalOrders;
          break;
        case 1:
          orders = orderScreenController.pendingOrders;
          break;
        case 2:
          orders = orderScreenController.placedOrders;
          break;
        default:
          orders = [];
      }

      return Column(
        children: [
          // Tab buttons

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () => orderScreenController.selectedTab.value = 0,
                    child: const Text("Total Orders",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  if(orderScreenController.selectedTab.value==0)Container(
                    width: 75,
                    height: 3,
                    color: Get.theme.colorScheme.primary,
                  )
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () => orderScreenController.selectedTab.value = 1,
                    child: const Text("Pending Orders",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  if(orderScreenController.selectedTab.value==1)Container(
                    width: 100,
                    height: 3,
                    color: Get.theme.colorScheme.primary,
                  )
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () => orderScreenController.selectedTab.value = 2,
                    child: const Text("Placed Orders",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  if(orderScreenController.selectedTab.value==2)Container(
                    width: 90,
                    height: 3,
                    color: Get.theme.colorScheme.primary,
                  )
                ],
              ),
            ],
          ),


          // List of orders
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            ),
          ),
        ],
      );
    });
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Get.theme.primaryColor,
      margin: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(order.date),
              Text("Customer Name\n ${order.customerName}"),
              Text("Delivery Status\n ${order.deliveryStatus}"),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Rs ${order.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Image.asset(
                order.imageUrl,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
