import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Scontrollers/DashboardScreenController/dashboard_all_report_controller.dart';


class DashboardAllReportScreen extends StatelessWidget {
  const DashboardAllReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardAllReportController controller = Get.put(DashboardAllReportController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Report'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Column(
        children: [

          Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['All', 'Today', 'This Month', 'This Year'].map((tab) {
                return GestureDetector(
                  onTap: () => controller.selectedTab.value = tab,
                  child: Column(
                    children: [
                      Text(
                        tab,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: controller.selectedTab.value == tab
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: controller.selectedTab.value == tab
                              ? Get.theme.colorScheme.primary
                              : Colors.black,
                        ),
                      ),
                      if (controller.selectedTab.value == tab)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 2,
                          width: 40,
                          color: Colors.pink.shade400,
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          )),

          // Bottom report section
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.currentReport.length,
                itemBuilder: (context, index) {
                  final reportItem = controller.currentReport[index];
                  return buildReportTile(
                    reportItem['label']!,
                    reportItem['value']!,
                    reportItem['change']!,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildReportTile(String label, String value, String change) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$change',
                style: TextStyle(color: Get.theme.colorScheme.primary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
