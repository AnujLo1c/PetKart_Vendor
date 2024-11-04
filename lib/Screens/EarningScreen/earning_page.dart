import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Scontrollers/EarningScreenController/earning_page_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class EarningPage extends StatelessWidget {
  const EarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EarningPageController earningsController = Get.put(EarningPageController());

      return  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Text(
                "This Month",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildEarningsCard("This Month", earningsController.currentEarnings, Icons.calculate,earningsController.percentageChangeCurrent),
                  buildEarningsCard("Last Month", earningsController.lastMonthEarnings,Icons.calendar_today_outlined,null),
                ],
              ),
              const Gap(20),
              buildTotalEarningsCard(earningsController.totalEarnings, earningsController.percentageChangeLast),
              const Gap( 20),
              buildButton(Icons.history, "Payment History", () {
Get.toNamed("/payment_history_screen");
              }),
              const Gap(20),
              // buildButton(Icons.settings, "Payment Setting", () {}),
            ],
          ),
      );
    }

  Widget buildEarningsCard(String title, RxInt amount, IconData icon, RxInt? percentage) {
    return Container(
      width: 150, // Adjust width as desired
      height: 150, // Adjust height as desired
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 40, color: Colors.black),
                  if (percentage != null) ...[
                    const SizedBox(width: 8),
                    Obx(() => Text("+${percentage.value}%", style: const TextStyle(color: Colors.green))),
                  ],
                ],
              ),
              const Gap(15),
              Obx(() => Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text("Rs ${amount.value}", style: const TextStyle(fontSize: 16), textAlign: TextAlign.left))),
              const Gap(2),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildTotalEarningsCard(RxInt totalEarnings, RxInt percentage) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2), // Customize color and width
        borderRadius: BorderRadius.circular(16), // Match the card's border radius
      ),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero, // Remove default margin for a tighter border fit
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 40, color: Colors.pink[200]),
                  Obx(() => Text("Rs ${totalEarnings.value}", style: const TextStyle(fontSize: 20))),
                  const Text("Total Earning", style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(
                height: 100, // Adjust size as needed
                width: 150,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 1),
                          const FlSpot(1, 3),
                          const FlSpot(2, 2),
                          const FlSpot(3, 5),
                          const FlSpot(4, 4),
                          const FlSpot(5, 6),
                          const FlSpot(6, 7),
                        ],
                        isCurved: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: true, ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


    Widget buildButton(IconData icon, String text, VoidCallback onPressed) {
      return SizedBox(
        width: Get.width-20,
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: Colors.white,
            side: BorderSide(color: Get.theme.colorScheme.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: onPressed,

          child: Row(
            children: [
              Icon(icon, color: Colors.black87),

              const Gap(10),Text(text, style: const TextStyle(color: Colors.black)),
            ],
          ),
        ),
      );
    }
  }
