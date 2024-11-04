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
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 80,
                    height: 3,
                    color: Get.theme.colorScheme.primary,
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () => orderScreenController.selectedTab.value = 1,
                    child: const Text("Pending Orders",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  if(orderScreenController.selectedTab.value==1)
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 95,
                    height: 3,
                    color: Get.theme.colorScheme.primary,
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () => orderScreenController.selectedTab.value = 2,
                    child: const Text("Placed Orders",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  if(orderScreenController.selectedTab.value==2)
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 90,
                    height: 3,
                    color: Get.theme.colorScheme.primary,
                  ),
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
                return GestureDetector(
                  //TODO:order[arr] management
                    onTap: ()=>Get.toNamed("/order_details_screen"),
                    child: OrderCard(order: order));
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.colorScheme.primary),
      color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
        BoxShadow(
          color: Get.theme.colorScheme.primary.withOpacity(.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 2)
        )
      ]
      ),

      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
Alignment _getAlignment(int selectedTab) {
  switch (selectedTab) {
    case 0:
      return Alignment.centerLeft; // Align to the first tab
    case 1:
      return Alignment.center; // Align to the second tab
    case 2:
      return Alignment.centerRight; // Align to the third tab
    default:
      return Alignment.centerLeft; // Default to the first tab
  }
}
