import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:petkart_vendor/Scontrollers/DashboardScreenController/dashboard_page_controller.dart';

import '../../Models/income_model.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardPageController dashboardPageController = Get.put(DashboardPageController());
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "This Month",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
print(dashboardPageController.incomeData);
                        Get.toNamed("/dashboard_all_report_screen",arguments: dashboardPageController.incomeData);
                      },
                      child: const Text("All Reports"))
                ],
              ),
              const Gap(5),
              SizedBox(
                  height: Get.height - 550,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('vendorusers')
                        .doc(EmailPassLoginAl().getEmail())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }

                      // Accessing the nested 'incomeData' field from the document
                      var incomeData = snapshot.data!.get('incomeData');

                      if (incomeData is List) {
                        final data = incomeData[2]; // Assuming you want the third item
                        // Replace 'imageURL' with the correct field name for the image
                        dashboardPageController.incomeData = IncomeModel.fromMap(data);
                        return GridView(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            StatCard(title: 'Earnings', amount: data['currentEarnings'].toString(),
                                growth: getGrowth(data['currentEarnings'],data['previousEarnings']).toString(), icon: Icons.money),

                            StatCard(title: 'Gross Sales', amount: data['currentGrossSales'].toString(),
                                growth: getGrowth(data['currentGrossSales'],data['previousGrossSales']).toString(), icon: Icons.do_not_disturb_on_total_silence),

                            StatCard(title: 'Product Sales', amount: data['currentProductSales'].toString(),
                                growth: getGrowth(data['currentProductSales'],data['previousProductSales']).toString(), icon: Icons.shopping_cart),

                            StatCard(title: 'Total Sales', amount: data['currentTotalSales'].toString(),
                                growth: getGrowth(data['currentTotalSales'],data['previousTotalSales']).toString(), icon: Icons.point_of_sale_sharp),
                          ],
                        );
                      } else {
                        return Text("Invalid data format for incomeData");
                      }
                    },
                  )

              ),
              Row(
                children: [
                  const Text(
                    "New Orders",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        dashboardPageController.navToOrders();
                      }, child: const Text("See All Orders"))
                ],
              ),
              const Gap(10),
              SizedBox(
                height: Get.height,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Gap(10),
                  itemBuilder: (BuildContext context, int index) {
                    return orderTile();
                  },
                  itemCount: 5,
                ),
              )
            ],
          )),
    );
  }
  String getGrowth(curr,prev) {
    if(prev==0)return '0%';
double d=(((curr+prev)/prev)*100);

    return d<=0?'O%':d.toStringAsFixed(1)+'%';
  }

  Widget orderTile() {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red), // Red border as per the image
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Order Id\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '20110204-asdsadf\n',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 4),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Customer Name\n',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Anuj Lowanshi\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Status\n',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Purchased\n',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                'assets/img/cat.png',
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              const Text(
                'Rs 3000',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String amount;
  final String growth;
  final IconData icon;

  const StatCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.growth,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: Get.theme.colorScheme.primary),
                Spacer(),
                Text(
                  growth,
                  style: TextStyle(
                    color: Colors
                        .green, // Change this color based on growth value if needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 6),
            Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
