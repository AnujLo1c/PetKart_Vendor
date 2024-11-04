import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Scontrollers/OrderScreenController/track_order_controller.dart';


class TrackOrderScreen extends StatelessWidget {

  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final TrackOrderController controller = Get.put(TrackOrderController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                  "${controller.orderStatus.value} by \n${controller.estimatedTime.value}",
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontSize: 22,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                const Image(
                  image: AssetImage('assets/img/cat.png'), 
                ),
              ],
            ),
            Divider(color: Colors.grey.shade500,),
            const SizedBox(height: 30),

            
            SizedBox(
              height: 350,
              child: ListView(
                children: [
                  buildTimelineTile(

                    "Ordered ${controller.orderedDate.value}",
                    true,
                  ),
                  buildTimelineTile(

                    "Shipped ${controller.shippedDate.value}",
                    true,
                    // additionalInfo: "See all updates",
                  ),
                  buildTimelineTile( "Arriving today", false),
                  buildTimelineTile( "Out for Delivery", false),
                  buildTimelineTile( "Delivered", false,additionalInfo: "f"),
                ],
              ),
            ),

            buildShippingDetails(context,controller),
          ],
        ),
      ),
    );
  }

  Widget buildTimelineTile( String status, bool isCompleted, {String? additionalInfo}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              color: isCompleted ? Get.theme.colorScheme.primary : Colors.grey,
              child: Icon(
                isCompleted ? Icons.check : Icons.radio_button_unchecked,
                color: isCompleted ? Colors.white : Colors.grey,

              ),
            ),
            if(additionalInfo!='f')Container(
              width: 5,
              height: 50,
              color: isCompleted ? Get.theme.colorScheme.primary : Colors.grey,
            ),
          ],
        ),
        const Gap(20),
        Text(
          status,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isCompleted ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  
  Widget buildShippingDetails(BuildContext context, TrackOrderController controller) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(16),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipped Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Buyer Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: controller.buyerName.value, style: const TextStyle(color: Colors.pinkAccent)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Buyer Address: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: controller.buyerAddress.value, style: const TextStyle(color: Colors.pinkAccent)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
