import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Scontrollers/EarningScreenController/payment_history_controller.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentHistoryController controller = Get.put(PaymentHistoryController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.primary,
        title: Text('Payment History'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.paymentHistoryList.isEmpty) {
            return Center(child: Text('No payment history available.'));
          } else {
            return ListView.builder(
              itemCount: controller.paymentHistoryList.length,
              itemBuilder: (context, index) {
                final payment = controller.paymentHistoryList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Account No:', payment.accountNumber),
                          _buildInfoRow('Holder Name:', payment.holderName),
                          _buildInfoRow('Bank:', payment.bankName),
                          _buildInfoRow('Date:', payment.date),
                          SizedBox(height: 16),
                          Divider(color: Colors.grey),
                          _buildInfoRow('Order Id:', payment.orderId, isBold: true),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
