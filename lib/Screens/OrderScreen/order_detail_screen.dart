import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../Scontrollers/OrderScreenController/order_details_controller.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailController controller = Get.put(OrderDetailController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.zero),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Obx(() => Container(
            width: Get.width,
            alignment: Alignment.center,
            color: Get.theme.colorScheme.secondary,
            height: 20,
            child: Text(
              'Order id: ${controller.orderId.value}',  
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
          const Gap(20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap( 10),

                Obx(() => Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.redAccent),
                  ),
                  child: DropdownButton<String>(
                    value: controller.orderStatus.value,  // Selected value bound to controller's orderStatus
                    isExpanded: true,
                    underline: const SizedBox(),  // Remove the default underline
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.orderStatus.value = newValue;  // Update the selected value
                      }
                    },
                    items: controller.vendorOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                )),

                const Gap( 20),
                Center(
                  child: ElevatedButton(
                    onPressed: controller.trackOrder,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Track Order'),
                  ),
                ),
                const Gap( 20),
                const Text(
                  'Shipment Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Gap( 10),
                
                Obx(() => Text.rich(
                  TextSpan(
                    text: 'Courier Name: ',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: controller.courierName.value,  
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                )),
                const Gap( 20),
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Gap( 10),
                
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderSummaryRow(
                      title: 'Order Code:',
                      value: controller.orderId.value,
                    ),
                    OrderSummaryRow(
                      title: 'Customer:',
                      value: controller.customerName.value,
                    ),
                    OrderSummaryRow(
                      title: 'Email:',
                      value: controller.customerEmail.value,
                    ),
                    OrderSummaryRow(
                      title: 'Shipping Address:',
                      value: controller.shippingAddress.value,
                    ),
                    OrderSummaryRow(
                      title: 'Order Date:',
                      value: controller.orderDate.value,
                    ),
                    OrderSummaryRow(
                      title: 'Order Status:',
                      value: controller.orderStatus.value,
                    ),
                    OrderSummaryRow(
                      title: 'Total Earning:',
                      value: controller.totalEarning.value,
                    ),
                    OrderSummaryRow(
                      title: 'Payment Method:',
                      value: controller.paymentMethod.value,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const OrderSummaryRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),  
        ],
      ),
    );
  }
}
